//
//  GameScene2.swift
//  BookCore
//
//  Created by Lucas Yoshio Nakano on 11/04/21.
//

import Foundation
import SpriteKit

public class GameScene2: SKScene {
    
    var itemsRound1: [(Sprite: SKSpriteNode, isAnswer: Bool, Selected: Bool)]! = []
    var itemsRound2: [(Sprite: SKSpriteNode, isAnswer: Bool, Selected: Bool)]! = []
    var itemsRound3: [(Sprite: SKSpriteNode, isAnswer: Bool, Selected: Bool)]! = []

    var round1, round2, round3, nextScene, calculating, relived, happy, sFried, fried, removeSprite: SKNode!

    var confirmGame, nextGame: SKSpriteNode!
    
    var labelResult: SKLabelNode!
    
    override public func didMove(to view: SKView) {
        
        round1 = self.childNode(withName: "Round1")
        round2 = self.childNode(withName: "Round2")
        round3 = self.childNode(withName: "Round3")
        calculating = self.childNode(withName: "calculando")
        relived = self.childNode(withName: "aliviado")
        happy = self.childNode(withName: "feliz")
        sFried = self.childNode(withName: "fritandoOvo")
        fried = self.childNode(withName: "ovoQueimado")
        round2.removeFromParent()
        round3.removeFromParent()
        relived.removeFromParent()
        happy.removeFromParent()
        sFried.removeFromParent()
        fried.removeFromParent()
        confirmGame = self.childNode(withName: "Confirm") as? SKSpriteNode
        nextGame = self.childNode(withName: "NextRound") as? SKSpriteNode
        nextGame.removeFromParent()
        labelResult = self.childNode(withName: "LabelResult") as? SKLabelNode

        for i in 1 ... 4 {
            if i == 1 || i == 2 || i == 3 {
                itemsRound1.append((round1?.childNode(withName: "item\(i)") as! SKSpriteNode, true, false))
            }
            else {
                itemsRound1.append((round1?.childNode(withName: "item\(i)") as! SKSpriteNode, false, false))
            }
        }

        for i in 1 ... 5 {
            if i == 1 || i == 2 || i == 5 {
                itemsRound2.append((round2?.childNode(withName: "item\(i)") as! SKSpriteNode, true, false))
            }
            else {
                itemsRound2.append((round2?.childNode(withName: "item\(i)") as! SKSpriteNode, false, false))
            }
        }

        for i in 1 ... 6 {
            if i == 1 || i == 4 || i == 6 {
                itemsRound3.append((round3?.childNode(withName: "item\(i)") as! SKSpriteNode, true, false))
            }
            else {
                itemsRound3.append((round3?.childNode(withName: "item\(i)") as! SKSpriteNode, false, false))
            }
        }
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if self.contains(round1) {
            for (index, item) in itemsRound1.enumerated() {
                if item.Sprite.contains(self.convert(pos, to: round1)) {
                    if item.Selected {
                        item.Sprite.setScale(1)
                        itemsRound1[index].Selected = false
                    }
                    else {
                        item.Sprite.setScale(1.3)
                        itemsRound1[index].Selected = true
                    }
                }
            }
            if confirmGame.contains(pos) {
                for item in itemsRound1 {
                    if item.Selected != item.isAnswer {
                        labelResult.text = "FAIL"
                        round1.removeFromParent()
                        calculating.removeFromParent()
                        confirmGame.removeFromParent()
                        removeSprite = happy
                        addChild(nextGame)
                        addChild(happy)
                        nextScene = round2
                        break
                    }
                    if item.Selected == item.isAnswer && item == itemsRound1.last! {
                        labelResult.text = "ACERTOU"
                        round1.removeFromParent()
                        calculating.removeFromParent()
                        confirmGame.removeFromParent()
                        removeSprite = relived
                        addChild(nextGame)
                        addChild(relived)
                        nextScene = round2
                    }
                }
            }
        }
        
        if self.contains(round2) {
            for (index, item) in itemsRound2.enumerated() {
                if item.Sprite.contains(self.convert(pos, to: round2)) {
                    if item.Selected {
                        item.Sprite.setScale(1)
                        itemsRound2[index].Selected = false
                    }
                    else {
                        item.Sprite.setScale(1.3)
                        itemsRound2[index].Selected = true
                    }
                }
            }
            if confirmGame.contains(pos) {
                for item in itemsRound2 {
                    if item.Selected != item.isAnswer {
                        labelResult.text = "FAIL"
                        round2.removeFromParent()
                        calculating.removeFromParent()
                        confirmGame.removeFromParent()
                        removeSprite = sFried
                        addChild(nextGame)
                        addChild(sFried)
                        nextScene = round3
                        break
                    }
                    if item.Selected == item.isAnswer && item == itemsRound2.last! {
                        labelResult.text = "ACERTOU"
                        round2.removeFromParent()
                        calculating.removeFromParent()
                        confirmGame.removeFromParent()
                        removeSprite = sFried
                        addChild(nextGame)
                        addChild(sFried)
                        nextScene = round3
                    }
                }
            }
        }
        
        if self.contains(round3) {
            for (index, item) in itemsRound3.enumerated() {
                if item.Sprite.contains(self.convert(pos, to: round3)) {
                    if item.Selected {
                        item.Sprite.setScale(1)
                        itemsRound3[index].Selected = false
                    }
                    else {
                        item.Sprite.setScale(1.3)
                        itemsRound3[index].Selected = true
                    }
                }
            }
            if confirmGame.contains(pos) {
                for item in itemsRound3 {
                    if item.Selected != item.isAnswer {
                        labelResult.text = "FAIL"
                        round3.removeFromParent()
                        calculating.removeFromParent()
                        confirmGame.removeFromParent()
                        removeSprite = fried
                        addChild(nextGame)
                        addChild(fried)
                        nextScene = nil
                        break
                    }
                    if item.Selected == item.isAnswer && item == itemsRound3.last! {
                        labelResult.text = "ACERTOU"
                        round3.removeFromParent()
                        calculating.removeFromParent()
                        confirmGame.removeFromParent()
                        removeSprite = fried
                        addChild(nextGame)
                        addChild(fried)
                        nextScene = nil
                    }
                }
            }
        }
        
        if nextGame.contains(pos) {
            if nextScene == nil {
                nextGame.removeFromParent()
                confirmGame.removeFromParent()
                labelResult.text = "GGWP"
                labelResult.position = CGPoint(x: 0, y: 0)
                removeSprite.removeFromParent()
            }
            else {
                addChild(nextScene)
                addChild(calculating)
                addChild(confirmGame)
                nextGame.removeFromParent()
                removeSprite.removeFromParent()
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
