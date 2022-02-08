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
        
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .clear
        
        MessageFactory.shared.startReceiveTimer()
        MessageFactory.shared.startConsumeTimer { [weak self] messages in
            for msg in messages {
                self?.addGoblin(withMessage: msg)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 15) {
            MessageFactory.shared.stopConsumeTimer()
            MessageFactory.shared.stopReceiveTimer()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension OverlayScene {
    
    func random() -> CGFloat {
      return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
      return random() * (max - min) + min
    }
    
    func addGoblin(withMessage message: Message) {
        guard let goblin = Skeleton(fromJSON: "goblins-ess", atlas: "Goblins", skin: "goblin") else {
          return
        }
        goblin.position = CGPoint(x: random(min: 10, max: size.width - 10), y: random(min: 10, max: size.height / 2))
        goblin.setScale(0.3)
        addChild(goblin)
        
        if let walk = goblin.animation(named: "walk") {
            goblin.run(SKAction.repeatForever(walk))
        }
        
        addName(for: goblin, dancer: message.sender)
        addBubble(for: goblin, message: message)
    }
    
    func addName(for goblin: SKNode, dancer: User) {
        let x: CGFloat = 0
        let y: CGFloat = -30
        let name = SKLabelNode(text: "\(dancer.uid)")
        name.fontSize = 50
        name.fontColor = .white
        name.fontName = "Helvetica"
        name.position = CGPoint(x: x, y: y)
        goblin.addChild(name)
    }
    
    func addBubble(for goblin: SKNode, message: Message, duration: TimeInterval = 3) {
        let bubble = SKLabelNode(text: message.content)
        bubble.fontColor = .black
        bubble.fontName = "Helvetica"
        bubble.fontSize = 50
        bubble.position = CGPoint(x: 0, y: -15)
        let sprite = SKSpriteNode(color: .white, size: CGSize(width: bubble.frame.width * 1.5, height: bubble.frame.height * 1.5))
        sprite.position = CGPoint(x: 0, y: 350)
        sprite.addChild(bubble)
        goblin.addChild(sprite)
        if duration < 0 {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            sprite.removeFromParent()
        }
    }
}

