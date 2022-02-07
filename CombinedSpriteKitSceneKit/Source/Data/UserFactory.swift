//
//  UserFactory.swift
//  CombinedSpriteKitSceneKit
//
//  Created by 周博立 on 2022/2/4.
//  Copyright © 2022 tutsplus. All rights reserved.
//

import Foundation

let kConsumeLength: Int = 5
let kConsumeInterval: TimeInterval = 1
let kInRoomUsrMaxCount: Int = 200

class UserFactory: NSObject {
    
    static let shared: UserFactory = UserFactory()
    static var consumer: (([User]) -> Void)? {
        get {
            let shared = UserFactory.shared
            return shared.consumer
        }
        set {
            let shared = UserFactory.shared
            shared.consumer = newValue
        }
    }
    
    var consumeInterval: TimeInterval = kConsumeInterval
    var consumeLength: Int = kConsumeLength
    var inRoomUsrMaxCount: Int = kInRoomUsrMaxCount
    var consumer: (([User]) -> Void)?
    var consumeTimer: Timer?
    
    lazy var dataSource: DataSource = DataSource()
    lazy var inRoomUsers: [User] = [User]()
    lazy var inRoomUserMap: [String: Any] = [String: Any]()
    lazy var op: DispatchQueue = DispatchQueue(label: "com.dance.data.op")
    
    static func consume(withTimeInterval interval: TimeInterval, length: Int, callback: @escaping (([User]) -> Void)) {
        let shared = UserFactory.shared
        shared.consumeLength = length
        shared.startTimer(withConsumer: callback, interval: interval)
    }
    
    func consume(_ callback: @escaping (([User]) -> Void)) {
        op.async {
            if self.inRoomUsers.count > self.consumeLength {
                var res: [User] = [User]()
                for (idx, usr) in self.inRoomUsers.enumerated() where idx < self.consumeLength {
                    res.append(usr)
                }
                for idx in 0..<self.consumeLength where self.inRoomUsers.count > idx {
                    if let usr = self.inRoomUsers.first {
                        self.inRoomUserMap.removeValue(forKey: usr.uid)
                        self.inRoomUsers.removeFirst()
                    }
                }
                callback(res)
            } else {
                let res: [User] = self.inRoomUsers
                self.inRoomUsers.removeAll()
                self.inRoomUserMap.removeAll()
                callback(res)
            }
        }
    }
    
    func produce(_ users: [User]) {
        op.async {
            self.inRoomUsers.append(contentsOf: users)
            if self.inRoomUsers.count > self.inRoomUsrMaxCount {
                let diffCount: Int = self.inRoomUsrMaxCount - self.inRoomUsers.count
                for idx in 0..<diffCount where self.inRoomUsers.count > idx {
                    self.inRoomUsers.removeFirst()
                }
            }
            for usr in self.inRoomUsers {
                self.inRoomUserMap[usr.uid] = usr
            }
        }
    }
    
    func stopTimer() {
        consumeTimer?.invalidate()
    }
    
    func startTimer(withConsumer con: @escaping (([User]) -> Void), interval: TimeInterval) {
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
