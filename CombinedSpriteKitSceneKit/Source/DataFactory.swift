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
    
    static func consume() -> [User]? {
        let shared = DataFactory.shared
        
        
        
        return nil
    }
}
