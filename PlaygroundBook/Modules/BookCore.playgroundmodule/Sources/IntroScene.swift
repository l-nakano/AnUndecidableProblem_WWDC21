//
//  IntroScene.swift
//  BookCore
//
//  Created by Lucas Yoshio Nakano on 18/04/21.
//

import Foundation
import SpriteKit
import AVFoundation

public class IntroScene: SKScene {
    
    var liveView, hideLabel, extremeLight, loadingBar, appleLogo: SKSpriteNode!
    var light: SKLightNode!
    var graphShapeNode: [SKShapeNode]! = []
    var re = 0.0
    var canGraph = false
    
    override public func didMove(to view: SKView) {
        liveView = self.childNode(withName: "liveView") as? SKSpriteNode
        light = liveView.childNode(withName: "light") as? SKLightNode
        hideLabel = self.childNode(withName: "hideLabel") as? SKSpriteNode
        extremeLight = self.childNode(withName: "extremeLight") as? SKSpriteNode
        loadingBar = self.childNode(withName: "loadingBar") as? SKSpriteNode
        appleLogo = self.childNode(withName: "appleLogo") as? SKSpriteNode
        light.isEnabled = false
        hideLabel.removeFromParent()
        loadingBar.removeFromParent()
        appleLogo.removeFromParent()
        
        addChild(hideLabel)
        let turnLightOn = SKAction.run {
            self.light.isEnabled = true
        }
        let flash = SKAction.run {
            self.extremeLight.zPosition = 1
            self.extremeLight.run(SKAction.fadeIn(withDuration: 1))
        }
        let changeTexture = SKAction.run {
            self.extremeLight.color = .black
        }
        let hide = SKAction.run {
            self.hideLabel.run(SKAction.fadeIn(withDuration: 1))
        }
        let sound = SKAction.run {
            GSAudio.sharedInstance.playSound(soundFileName: "Start_Mac")
        }
        let graph = SKAction.run {
            self.canGraph.toggle()
            self.loadingBar.zPosition = 1
            self.appleLogo.zPosition = 1
            self.addChild(self.loadingBar)
            self.addChild(self.appleLogo)
        }
        let actions = [SKAction.wait(forDuration: 1), hide, SKAction.wait(forDuration: 1), turnLightOn, flash, SKAction.wait(forDuration: 1.5), changeTexture, SKAction.wait(forDuration: 0.5), sound, SKAction.wait(forDuration: 0.5), graph]
        self.run(SKAction.sequence(actions))
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }

    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }

    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        if canGraph && re < 543 {
            let circle = SKShapeNode(circleOfRadius: 8)
            circle.fillColor = .white
            circle.strokeColor = .white
            circle.position = CGPoint(x: re - 268, y: 0)
            circle.zPosition = 1
            graphShapeNode.append(circle)
            addChild(graphShapeNode.last!)
            re += 3
        }
        if re >= 543 {
            let scene = DialogScene1(fileNamed: "DialogScene1")!
            scene.scaleMode = .aspectFit
            self.view?.presentScene(scene)
        }
    }
}
