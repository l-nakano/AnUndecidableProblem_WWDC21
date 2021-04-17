//
//  DialogScene2.swift
//  BookCore
//
//  Created by Lucas Yoshio Nakano on 14/04/21.
//

// Aparecer uma letra por vez
//let typeInterval = SKAction.wait(forDuration: 0.07)
//
//         let (nextChar, totalCount) = TypeWriter().createAction(for: firstText)
//
//         firstText.text = ""
//
//         let typeSequence = SKAction.sequence([typeInterval, nextChar])
//
//         firstText.run(.sequence([.wait(forDuration: 0.3),.repeat(typeSequence, count: totalCount)]))

import Foundation
import SpriteKit

public class DialogScene2: SKScene {
    
    var normalSecond, thinking, happy, starEyes, iOSwindow, rich, dialogBar: SKNode!
    var labelDialog: SKLabelNode!
    var dialogs = ["How could you feel, the knapsack problem takes too long than the challenge of finding the number",
                   "No person or computer found a solution that makes the knapsack problem a complex class P",
                   "This is considered a undecidable problem for the science, known as \"P vs NP\"",
                   "It is one of the Millenium Prize Problems!",
                   "If you want to, we can unite to try to be the next milionaires!"]
    var allScenes = [[SKNode]]()
    
    override public func didMove(to view: SKView) {
        normalSecond = self.childNode(withName: "normalSegundo")
        dialogBar = self.childNode(withName: "barraFala")
        thinking = self.childNode(withName: "pensativo")
        happy = self.childNode(withName: "feliz")
        starEyes = self.childNode(withName: "olhosEstrelas")
        iOSwindow = self.childNode(withName: "janelaiOS")
        rich = self.childNode(withName: "pensandoRico")
        thinking.removeFromParent()
        happy.removeFromParent()
        starEyes.removeFromParent()
        iOSwindow.removeFromParent()
        rich.removeFromParent()
        labelDialog = self.childNode(withName: "labelFala") as? SKLabelNode
        labelDialog.text = dialogs.first
        
        allScenes = [[normalSecond], [thinking], [happy], [starEyes], [iOSwindow, rich, starEyes]]
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if self.contains(pos) {
            if dialogs.count == 1 {
//                let gameScene1 = GameScene1(fileNamed: "GameScene1")!
//                gameScene1.scaleMode = .aspectFit
//                self.view?.presentScene(gameScene1)
            } else {
                for myScene in allScenes.first! {
                    myScene.removeFromParent()
                }
                allScenes.remove(at: 0)
                dialogs.remove(at: 0)
                for myScene in allScenes.first! {
                    switch myScene.name {
                    case "janelaiOS":
                        myScene.alpha = 0
                        myScene.setScale(0.0)
                        myScene.position = CGPoint(x: -359, y: -256)
                        addChild(myScene)
                        myScene.run(SKAction.scale(to: 0.7, duration: 0.5))
                        myScene.run(SKAction.fadeIn(withDuration: 0.3))
                        myScene.run(SKAction.move(to: CGPoint(x: -71.944, y: 86.601), duration: 0.5))
                    case "pensandoRico":
                        myScene.alpha = 0
                        myScene.setScale(0.0)
                        myScene.position = CGPoint(x: -359, y: -256)
                        addChild(myScene)
                        myScene.run(SKAction.scale(to: 0.35, duration: 0.5))
                        myScene.run(SKAction.fadeIn(withDuration: 0.3))
                        myScene.run(SKAction.move(to: CGPoint(x: -71.944, y: 68.893), duration: 0.5))
                    default:
                        addChild(myScene)
                    }
                }
                labelDialog.text = dialogs.first
            }
        }
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
        // Called before each frame is rendered
    }
}
