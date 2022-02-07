//
//  MessageFactory.swift
//  CombinedSpriteKitSceneKit
//
//  Created by 周博立 on 2022/2/7.
//  Copyright © 2022 tutsplus. All rights reserved.
//

import Foundation

let kMsgConsumeLength: Int = 10
let kMsgConsumeInterval: TimeInterval = 1

class MessageFactory: NSObject {
    
    static let shared: MessageFactory = MessageFactory()

    static var consumer: (([Message]) -> Void)? {
        get {
            let shared = MessageFactory.shared
            return shared.consumer
        }
        set {
            let shared = MessageFactory.shared
            shared.consumer = newValue
        }
    }
    var userFactory: UserFactory {
        UserFactory.shared
    }
    var consumeLength: Int = kMsgConsumeLength
    var consumeInterval: TimeInterval = kMsgConsumeInterval
    var consumer: (([Message]) -> Void)?
    var consumeTimer: Timer?
    
    lazy var dataSource: DataSource = DataSource()
    lazy var caches: [Message] = [Message]()
    lazy var op: DispatchQueue = DispatchQueue(label: "com.dance.msg.op")
    
    func receive(_ messages: [Message]) {
        op.async {
            self.caches.append(contentsOf: messages)
            var usrs = [User]()
            for msg in messages {
                usrs.append(msg.sender)
            }
            self.receive(usrs)
        }
    }
    
    func receive(_ users: [User]) {
        userFactory.inRoomUsers.append(contentsOf: users)
        if userFactory.inRoomUsers.count > userFactory.inRoomUsrMaxCount {
            let diffCount: Int = userFactory.inRoomUsrMaxCount - userFactory.inRoomUsers.count
            for idx in 0..<diffCount where userFactory.inRoomUsers.count > idx {
                userFactory.inRoomUsers.removeFirst()
            }
        }
        for usr in userFactory.inRoomUsers {
            userFactory.inRoomUserMap[usr.uid] = usr
        }
    }
    
    static func consume(withTimeInterval interval: TimeInterval, length: Int, callback: @escaping (([Message]) -> Void)) {
        let shared = MessageFactory.shared
        shared.consumeLength = length
        shared.startTimer(withConsumer: callback, interval: interval)
    }
    
    func consume(_ callback: @escaping (([Message]) -> Void)) {
        op.async {
            if self.caches.count > self.consumeLength {
                var res: [Message] = [Message]()
                for (idx, msg) in self.caches.enumerated() where idx < self.consumeLength {
                    res.append(msg)
                }
                for idx in 0..<self.consumeLength where self.caches.count > idx {
                    self.caches.removeFirst()
                }
                callback(res)
            } else {
                let res: [Message] = self.caches
                callback(res)
                self.caches.removeAll()
            }
        }
    }
    
    func stopTimer() {
        consumeTimer?.invalidate()
    }
    
    func startTimer(withConsumer con: @escaping (([Message]) -> Void), interval: TimeInterval) {
        consumer = con
        consumeInterval = interval
        let timer: Timer = Timer(timeInterval: consumeInterval, repeats: true) { [weak self] _ in
            self?.consume({ users in
                self?.consumer?(users)
            })
        }
        RunLoop.main.add(timer, forMode: .common)
        timer.fire()
        consumeTimer = timer
    }
    
}
