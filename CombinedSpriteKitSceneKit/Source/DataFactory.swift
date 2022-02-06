//
//  DataFactory.swift
//  CombinedSpriteKitSceneKit
//
//  Created by 周博立 on 2022/2/4.
//  Copyright © 2022 tutsplus. All rights reserved.
//

import Foundation

let kConsumeLength: NSInteger = 5
let kConsumeInterval: TimeInterval = 1

class DataFactory: NSObject {
    
    static let shared: DataFactory = DataFactory()
    
    static var consumer: (([User]) -> Void)? {
        get {
            let shared = DataFactory.shared
            return shared.consumer
        }
        set {
            let shared = DataFactory.shared
            shared.consumer = newValue
        }
    }
    
    var consumeInterval: TimeInterval = kConsumeInterval
    
    var consumeLength: NSInteger = kConsumeLength
    
    var consumer: (([User]) -> Void)?
    
    var consumeTimer: Timer?
    
    lazy var dataSource: DataSource = DataSource()
    
    lazy var inRoomUsers: [User] = [User]()
    
    lazy var op: DispatchQueue = DispatchQueue(label: "com.dance.data.op")
    
    static func consume(withTimeInterval interval: TimeInterval, length: NSInteger, callback: @escaping (([User]) -> Void)) {
        let shared = DataFactory.shared
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
                for _ in 0..<self.consumeLength {
                    self.inRoomUsers.removeFirst()
                }
                callback(res)
            } else {
                let res: [User] = self.inRoomUsers
                self.inRoomUsers.removeAll()
                callback(res)
            }
        }
    }
    
    func produce(_ users: [User]) {
        op.async {
            self.inRoomUsers.append(contentsOf: users)
        }
    }
    
    func stopTimer() {
        consumeTimer?.invalidate()
    }
    
    @discardableResult
    func startTimer(withConsumer con: @escaping (([User]) -> Void), interval: TimeInterval) -> Timer? {
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
        return timer
    }
}
