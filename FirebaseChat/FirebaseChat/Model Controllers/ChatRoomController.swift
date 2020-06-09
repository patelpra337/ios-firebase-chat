//
//  ChatRoomController.swift
//  FirebaseChat
//
//  Created by patelpra on 6/8/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ChatRoomController {
    private let roomsRef = Database.database().reference().child("rooms")
    
    func createRoomWith(name: String) {
        let newRoomRef = roomsRef.childByAutoId()
        guard let identifier = newRoomRef.key else { return }
        let room = ChatRoom(identifier: identifier, name: name)
        newRoomRef.setValue(room.dictionaryRepresentation)
        fetchRooms()
    }
    
    func fetchRooms() {
        roomsRef.observe(.value) { (snapshot) in
            guard let dictionaries = snapshot.value as? [String : [String : String]] else { return }
            let rooms = dictionaries.compactMap({ ChatRoom(dictionary: $0.value) })
            self.rooms = rooms
        }
    }
    
    var rooms: [ChatRoom] = [] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .roomsWereUpdated, object: nil)
            }
        }
    }
}

