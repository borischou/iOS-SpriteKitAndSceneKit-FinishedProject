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
    lazy var cameraNode: SCNNode = SCNNode()
    lazy var lightNode: SCNNode = SCNNode()
    
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
        
        buildSet()
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
    
    func buildSet() {
        let anglelw = Float.pi / 2
        let widthWall = 25.0
        let heightWall = 25.0
        
        //设置左边墙
        let leftWall = SCNPlane(width: widthWall, height: heightWall)
        let lwNode = SCNNode(geometry: leftWall)
        lwNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "wall")?.cgImage
        lwNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: anglelw)
        lwNode.position = SCNVector3(-(widthWall / 2), heightWall / 2, 0)
        rootNode.addChildNode(lwNode)
        
        //设置右边墙
        let rightWall = SCNPlane(width: widthWall, height: heightWall)
        let rwNode = SCNNode(geometry: rightWall)
        rwNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "wall")?.cgImage
        rwNode.rotation = SCNVector4(x: 0, y: 1, z: 0, w: -anglelw)
        rwNode.position = SCNVector3(widthWall / 2, heightWall / 2, 0)
        rootNode.addChildNode(rwNode)
        
        //设置背景
        let wback = 26.0, hback = 15.0
        let backWall = SCNPlane(width: wback, height: hback)
        let wallNode = SCNNode(geometry: backWall)
        wallNode.position = SCNVector3(0, hback / 2.5, -(wback / 2))
        wallNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "lothar")?.cgImage
        rootNode.addChildNode(wallNode)
        
        //设置地板
        let wfloor = 25.0, hfloor = 25.0
        let anglefloor = -CGFloat.pi / 2.1
        let danceFloor = SCNPlane(width: wfloor, height: hfloor)
        let floorNode = SCNNode(geometry: danceFloor)
        floorNode.position = SCNVector3(0, 0, 0)
        floorNode.rotation = SCNVector4(1, 0, 0, anglefloor)
        floorNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "hardwood_floor")?.cgImage
        rootNode.addChildNode(floorNode)
        
        //设置光影
        let omniLight = SCNLight()
        omniLight.type = SCNLight.LightType.omni
        lightNode.light = omniLight
        lightNode.position = SCNVector3(x: 0, y: 5, z: 0)
        
        //设置镜头
        let camera = SCNCamera()
        let cameraConstraint = SCNLookAtConstraint(target: floorNode)
        cameraConstraint.isGimbalLockEnabled = true
        cameraNode.camera = camera
        cameraNode.constraints = [cameraConstraint]
        cameraNode.light = omniLight
        cameraNode.position = SCNVector3(x: 0, y: 1, z: 10)
        rootNode.addChildNode(cameraNode)
    }
}

