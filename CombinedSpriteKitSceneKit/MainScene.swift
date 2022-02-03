//
//  MainScene.swift
//  CombinedSpriteKitSceneKit
//
//  Created by Davis Allie on 21/05/2015.
//  Copyright (c) 2015 tutsplus. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class MainScene: SCNScene {
    
    var cubeNode: SCNNode!
    var cameraNode: SCNNode!
    var lightNode: SCNNode!
    
    override init() {
        super.init()
        
        /*
        //设置纹理
        let materialScene = SKScene(size: CGSize(width: 100, height: 100))
        let backgroundNode = SKSpriteNode(color: .blue, size: materialScene.size)
        backgroundNode.position = CGPoint(x: materialScene.size.width / 2.0, y: materialScene.size.height / 2.0)
        materialScene.addChild(backgroundNode)
        
        //设置纹理变化action
        let blueAction = SKAction.colorize(with: .blue, colorBlendFactor: 1, duration: 1)
        let redAction = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 1)
        let greenAction = SKAction.colorize(with: .green, colorBlendFactor: 1, duration: 1)
        backgroundNode.run(.repeatForever(.sequence([blueAction, redAction, greenAction])))
        
        //设置方块
        let cube = SCNBox(width: 3, height: 3, length: 3, chamferRadius: 0)
        let cubeMaterial = SCNMaterial()
        cubeMaterial.diffuse.contents = materialScene
        cube.materials = [cubeMaterial]
        cubeNode = SCNNode(geometry: cube)
        cubeNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.01, z: 0, duration: 1.0/60.0)))
        
        //设置镜头
        let camera = SCNCamera()
        camera.xFov = 60
        camera.yFov = 60
        let cameraConstraint = SCNLookAtConstraint(target: cubeNode)
        cameraConstraint.isGimbalLockEnabled = true
        
        //设置光影
        let ambientLight = SCNLight()
        ambientLight.type = SCNLight.LightType.ambient
        ambientLight.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        //节点化镜头
        cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.constraints = [cameraConstraint]
        cameraNode.light = ambientLight
        cameraNode.position = SCNVector3(x: 5, y: 5, z: 5)
        
        //节点化光影
        let omniLight = SCNLight()
        omniLight.type = SCNLight.LightType.omni
        lightNode = SCNNode()
        lightNode.light = omniLight
        lightNode.position = SCNVector3(x: -3, y: 5, z: 3)
        
        rootNode.addChildNode(cubeNode)
        rootNode.addChildNode(cameraNode)
        rootNode.addChildNode(lightNode)
         */
        
        //设置平面
        let plane = SCNPlane(width: 25, height: 25)
        let planeNode = SCNNode(geometry: plane)
        let position = SCNVector3(0, 0, 0)
        planeNode.position = position
        planeNode.rotation = SCNVector4(1, 0, 0, -CGFloat.pi / 2.5)
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "hardwood_floor")?.cgImage
        rootNode.addChildNode(planeNode)
        
        //设置光影
        let ambientLight = SCNLight()
        ambientLight.type = SCNLight.LightType.ambient
        ambientLight.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        //设置镜头
        let camera = SCNCamera()
        let cameraConstraint = SCNLookAtConstraint(target: planeNode)
        cameraConstraint.isGimbalLockEnabled = true
        cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.constraints = [cameraConstraint]
        cameraNode.light = ambientLight
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        rootNode.addChildNode(cameraNode)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "isPaused" {
            if let c = change, let p = c[NSKeyValueChangeKey.newKey] as? Bool {
                isPaused = p
            }
        }
    }
}

