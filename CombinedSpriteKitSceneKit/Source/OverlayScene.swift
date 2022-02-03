//
//  PauseScene.swift
//  CombinedSpriteKitSceneKit
//
//  Created by Davis Allie on 21/05/2015.
//  Copyright (c) 2015 tutsplus. All rights reserved.
//

import UIKit
import SpriteKit
import Spine

class OverlayScene: SKScene {
    
    var pauseNode: SKSpriteNode!
    var scoreNode: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreNode.text = "Score: \(score)"
        }
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .clear
        
        let spriteSize = size.width/12
        pauseNode = SKSpriteNode(imageNamed: "Pause Button")
        pauseNode.size = CGSize(width: spriteSize, height: spriteSize)
        pauseNode.position = CGPoint(x: spriteSize + 8, y: spriteSize + 8)
        
        scoreNode = SKLabelNode(text: "Score: 0")
        scoreNode.fontName = "DINAlternate-Bold"
        scoreNode.fontColor = .black
        scoreNode.fontSize = 24
        scoreNode.position = CGPoint(x: size.width/2, y: pauseNode.position.y - 9)
        
        //addChild(pauseNode)
        //addChild(scoreNode)
        
        addGoblin()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        
        if pauseNode.contains(location!) {
            if !isPaused {
                pauseNode.texture = SKTexture(imageNamed: "Play Button")
            } else {
                pauseNode.texture = SKTexture(imageNamed: "Pause Button")
            }
            
            isPaused = !isPaused
        }
    }
    
    func addGoblin() {
        guard let goblin = Skeleton(fromJSON: "goblins-ess", atlas: "Goblins", skin: "goblin") else {
          return
        }
        goblin.position = CGPoint(x: size.width / 2, y: size.height / 2)
        goblin.setScale(0.3)
        addChild(goblin)
    }
}

