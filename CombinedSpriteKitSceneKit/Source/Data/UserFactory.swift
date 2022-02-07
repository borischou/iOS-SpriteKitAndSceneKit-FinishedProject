//
//  UserFactory.swift
//  CombinedSpriteKitSceneKit
//
//  Created by 周博立 on 2022/2/4.
//  Copyright © 2022 tutsplus. All rights reserved.
//

import Foundation

let kInRoomUsrMaxCount: Int = 200

class UserFactory: NSObject {
    static let shared: UserFactory = UserFactory()
    lazy var inRoomUsers: [User] = [User]()
    lazy var inRoomUserMap: [String: Any] = [String: Any]()
    var inRoomUsrMaxCount: Int = kInRoomUsrMaxCount
}
