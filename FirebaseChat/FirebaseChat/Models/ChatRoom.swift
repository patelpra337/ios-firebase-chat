//
//  ChatRoom.swift
//  FirebaseChat
//
//  Created by patelpra on 6/8/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

class ChatRoom {
    
    
    static private let identifierKey = "identifier"
    static private let nameKey = "name"
    
    let identifer: String
    let name: String
    
    var messages: [Message] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .messagesWereUpdate, object: self)
            }
        }
    }
    
    var dictionaryRepresentation: [String : String] {
        return [ChatRoom.identifierKey : identifer, ChatRoom.nameKey : name]
    }
    
    init(identifer: String = UUID().uuidString, name: String, messages: [Message] = []) {
        self.identifer = identifer
        self.name = name
        self.messages = messages
    }
    
    convenience init?(dictionary: [String : String], messages: [Message] = []) {
        guard let identifier = dictionary[ChatRoom.identifierKey],
            let name = dictionary[ChatRoom.nameKey] else { return nil }
        
        self.init(identifier: identifier, name: name, messages: messages)
        
    }
}

extension Notification.Name {
    static let roomsWereUpdated = Notification.Name("roomsWereUpdated")
    static let messagesWereUpdate = Notification.Name("messagesWereUpdated")
}
