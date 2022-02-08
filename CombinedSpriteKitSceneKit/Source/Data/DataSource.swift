//
//  DataSource.swift
//  CombinedSpriteKitSceneKit
//
//  Created by 周博立 on 2022/2/4.
//  Copyright © 2022 tutsplus. All rights reserved.
//

import Foundation

class Dancer: User {
    var uid: String
    var avatar: String?
    
    init(withUid uid: String, avatar: String?) {
        self.uid = uid
        self.avatar = avatar
    }
}

class DanceMessage: Message {
    var sender: User
    var mid: String
    var content: String?
    
    init(withSender sender: Dancer, mid: String, content: String?) {
        self.sender = sender
        self.mid = mid
        self.content = content
    }
}

class DataSource: NSObject {
    static func getMessages(callback: (([Message]) -> Void)?) {
        let msgs = DataSource.testMsgs()
        callback?(msgs)
    }
    
    static func testMsgs() -> [Message] {
        let usr0 = Dancer(withUid: "aaa", avatar: nil)
        let msg0 = DanceMessage(withSender: usr0, mid: "AAA", content: "hello im aaa")
        
        let usr1 = Dancer(withUid: "bbb", avatar: nil)
        let msg1 = DanceMessage(withSender: usr1, mid: "BBB", content: "hello im bbb")
        
        let usr2 = Dancer(withUid: "ccc", avatar: nil)
        let msg2 = DanceMessage(withSender: usr2, mid: "CCC", content: "hello im ccc")
        
        let usr3 = Dancer(withUid: "ddd", avatar: nil)
        let msg3 = DanceMessage(withSender: usr3, mid: "DDD", content: "hello im ddd")
        
        let usr4 = Dancer(withUid: "eee", avatar: nil)
        let msg4 = DanceMessage(withSender: usr4, mid: "EEE", content: "hello im eee")
        
        return [msg0, msg1, msg2, msg3, msg4]
    }
}
