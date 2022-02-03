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
        
        run(SKAction.repeatForever(
          SKAction.sequence([
            SKAction.run(addGoblin),
            SKAction.wait(forDuration: 1.0)
            ])
        ))
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
    
    func random() -> CGFloat {
      return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
    
    func addGoblin() {
        guard let goblin = Skeleton(fromJSON: "goblins-ess", atlas: "Goblins", skin: "goblin") else {
          return
        }
        goblin.position = CGPoint(x: random(min: 10, max: size.width - 10), y: random(min: 10, max: size.height / 2))
        goblin.setScale(0.3)
        addChild(goblin)
        
        if let walk = goblin.animation(named: "walk") {
            goblin.run(SKAction.repeatForever(walk))
        }
        
        addName(for: goblin)
        addBubble(said: "hello", for: goblin)
    }
    
    func addName(for goblin: SKNode) {
        let x: CGFloat = 0
        let y: CGFloat = -30
        let name = SKLabelNode(text: "我是昵称")
        name.fontSize = 50
        name.fontColor = .white
        name.fontName = "Helvetica"
        name.position = CGPoint(x: x, y: y)
        goblin.addChild(name)
    }
    
    func addBubble(said text: String, for goblin: SKNode) {
        let bubble = SKLabelNode(text: text)
        bubble.fontColor = .black
        bubble.fontName = "Helvetica"
        bubble.fontSize = 50
        bubble.position = CGPoint(x: 0, y: -15)
        let sprite = SKSpriteNode(color: .white, size: CGSize(width: bubble.frame.width * 1.5, height: bubble.frame.height * 1.5))
        sprite.position = CGPoint(x: 0, y: 350)
        sprite.addChild(bubble)
        goblin.addChild(sprite)
    }
}

