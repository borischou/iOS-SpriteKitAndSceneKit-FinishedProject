//
//  ViewController.swift
//  CombinedSpriteKitSceneKit
//
//  Created by Davis Allie on 21/05/2015.
//  Copyright (c) 2015 tutsplus. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    var sceneView: SCNView!
    var spriteScene: OverlayScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        sceneView.scene = MainScene()
        view.addSubview(sceneView)
        
        spriteScene = OverlayScene(size: view.bounds.size)
        sceneView.overlaySKScene = spriteScene
        
        spriteScene.addObserver(sceneView.scene!, forKeyPath: "isPaused", options: .new, context: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: sceneView)
        let hitResults = sceneView.hitTest(location!, options: nil)
        
        for result in (hitResults) {
            if result.node == (sceneView.scene as! MainScene).cubeNode {
                spriteScene.score += 1
            }
        }
    }
}

