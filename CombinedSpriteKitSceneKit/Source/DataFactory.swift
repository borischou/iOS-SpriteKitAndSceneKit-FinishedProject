//
//  DataFactory.swift
//  CombinedSpriteKitSceneKit
//
//  Created by 周博立 on 2022/2/4.
//  Copyright © 2022 tutsplus. All rights reserved.
//

import Foundation

let kConsumeLength: NSInteger = 5

class DataFactory: NSObject {
    
    static let shared: DataFactory = DataFactory()
    
    lazy var inRoomUsers: [User] = [User]()
    
    lazy var op: DispatchQueue = DispatchQueue(label: "com.xhs.datafactory.opqueue")
    
    static func consume(_ callback: @escaping (([User]) -> Void)) {
        let shared = DataFactory.shared
        shared.op.async {
            if shared.inRoomUsers.count > kConsumeLength {
                var res: [User] = [User]()
                for (idx, usr) in shared.inRoomUsers.enumerated() where idx < kConsumeLength {
                    res.append(usr)
                }
                for _ in 0..<kConsumeLength {
                    shared.inRoomUsers.removeFirst()
                }
                callback(res)
            } else {
                let res: [User] = shared.inRoomUsers
                shared.inRoomUsers.removeAll()
                callback(res)
            }
        }
    }
    
    static func produce(_ users: [User]) {
        let shared = DataFactory.shared
        shared.op.async {
            shared.inRoomUsers.append(contentsOf: users)
        }
    }
}
