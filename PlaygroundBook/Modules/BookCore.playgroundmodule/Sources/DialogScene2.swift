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
    
    var normalSecond, thinking, happy, starEyes, thinkingBalloon, rich, dialogBar: SKNode!
    var labelDialog: SKLabelNode!
    var dialogs = ["Como você pôde sentir, o problema da mochila demora muito mais do que o desafio de encontrar um número em uma sequência",
                   "Até hoje, nenhuma pessoa ou máquinas conseguiu encontrar uma solução que torne o problema da mochila um problema P",
                   "Este é considerado um problema indecidível para a ciência, conhecido como P vs NP",
                   "Ficou conhecido como um dos Millennium Prize Problems!",
                   "Caso queira tentar, podemos nos juntar para tentarmos ser os próximos milinários!"]
    var allScenes = [[SKNode]]()
    
    override public func didMove(to view: SKView) {
        normalSecond = self.childNode(withName: "normalSegundo")
        dialogBar = self.childNode(withName: "barraFala")
        thinking = self.childNode(withName: "pensativo")
        happy = self.childNode(withName: "feliz")
        starEyes = self.childNode(withName: "olhosEstrelas")
        thinkingBalloon = self.childNode(withName: "balaoPensamento")
        rich = self.childNode(withName: "pensandoRico")
        thinking.removeFromParent()
        happy.removeFromParent()
        starEyes.removeFromParent()
        thinkingBalloon.removeFromParent()
        rich.removeFromParent()
        labelDialog = self.childNode(withName: "labelFala") as? SKLabelNode
        labelDialog.text = dialogs.first
        
        allScenes = [[normalSecond], [thinking], [happy], [starEyes], [starEyes, thinkingBalloon, rich]]
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if dialogBar.contains(pos) {
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
                    addChild(myScene)
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
