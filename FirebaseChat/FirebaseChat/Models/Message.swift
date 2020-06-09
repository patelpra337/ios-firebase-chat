//
//  Message.swift
//  FirebaseChat
//
//  Created by patelpra on 6/8/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import MessageKit

struct Message: MessageType {
    
    static let senderKey = "senderType"
    static let sentDatekey = "sentDate"
    static let messageIdKey = "messageId"
    static let kindKey = "text"
    
    let sender: SenderType
    let sentDate: Date
    let messageId: String
    let kind: MessageKind
    
    var text: String {
        let text: String
        
        switch kind {
        case .text(let messageText):
            text = messageText
        default:
            text = ""
        }
        
        return text
    }
    
    init(sender: SenderType, sentDate: Date = Date(), messageId: String, text: String) {
        
        self.sender = SenderType.self as! SenderType
        self.sentDate = sentDate
        self.messageId = messageId
        self.kind = MessageKind.text(text)
    }
    
    init?(dictionary: [String: Any]) {
        
        guard let senderDict = dictionary[Message.senderKey] as? [String : String],
            let sender = Sender(dictionary: senderDict),
            let sentDateTimeInterval = dictionary[Message.sentDatekey] as? TimeInterval,
            let messageId = dictionary[Message.messageIdKey] as? String,
            let text = dictionary[Message.kindKey] as? String else { return nil }
        
        let sentDate = Date(timeIntervalSince1970: sentDateTimeInterval)
        
        self.init(sender: sender, sentDate: sentDate, messageId: messageId, text: text)
            
    }
    
    var dictionaryRepresentation: [String: Any] {
        
        return[Message.senderKey : sender.dictionaryRepresentaton,
               Message.sentDatekey : sentDate.timeIntervalSince1970,
               Message.messageIdKey : messageId,
               Message.kindKey : text]
    }
}

extension SenderType {
    
    private static let idKey = "id"
    private static let displayNameKey = "displayName"
    
    var dictionaryRepresentation: [String : String] {
        return [SenderType.idKey : id,
                SenderType.displayNameKey : displayName]
    }
    
    init?(dictionary: [String : String]) {
        guard let id = dictionary[SenderType.idkey],
            let displayName = dictionary[SenderType.displayName] else { return nil }
        
        self.init(id: id, displayName: displayName)
    }
}
