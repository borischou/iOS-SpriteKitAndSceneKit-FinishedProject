//
//  DataProtocol.swift
//  CombinedSpriteKitSceneKit
//
//  Created by 周博立 on 2022/2/4.
//  Copyright © 2022 tutsplus. All rights reserved.
//

import Foundation

protocol User: AnyObject {
    var uid: String { get set }
    var avatar: String? { get set }
}

protocol Message: AnyObject {
    var sender: User { get set }
    var content: String? { get set }
    var mid: String { get set }
}
