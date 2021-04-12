import Foundation
import SpriteKit

public class GameScene: SKScene {
    
    var buttonsR1: [(Sprite: SKSpriteNode, Selected: Bool, IsAnswer: Bool)]! = []
    var buttonsR2: [(Sprite: SKSpriteNode, Selected: Bool, IsAnswer: Bool)]! = []
    var buttonsR3: [(Sprite: SKSpriteNode, Selected: Bool, IsAnswer: Bool)]! = []
    var confirmGame, nextGame: SKSpriteNode!
    var round1, round2, round3, calculating, scared, happy, okay, angry, nextScene, removeSprite: SKNode!
    var labelResult: SKLabelNode!
    
    override public func didMove(to view: SKView) {
        round1 = self.childNode(withName: "Round1")
        round2 = self.childNode(withName: "Round2")
        round3 = self.childNode(withName: "Round3")
        calculating = self.childNode(withName: "calculando")
        scared = self.childNode(withName: "assustado")
        happy = self.childNode(withName: "feliz")
        okay = self.childNode(withName: "okay")
        angry = self.childNode(withName: "pistola")
        round2.removeFromParent()
        round3.removeFromParent()
        scared.removeFromParent()
        happy.removeFromParent()
        okay.removeFromParent()
        angry.removeFromParent()
        confirmGame = self.childNode(withName: "Confirm") as? SKSpriteNode
        nextGame = self.childNode(withName: "NextRound") as? SKSpriteNode
        nextGame.removeFromParent()
        labelResult = self.childNode(withName: "LabelResult") as? SKLabelNode
        
        for i in 1 ... 10 {
            buttonsR1.append((round1?.childNode(withName: "NotSelecetedG1R\(i)") as! SKSpriteNode, false, false))
        }
        buttonsR1[6].IsAnswer = true
        
        for i in 1 ... 20 {
            buttonsR2.append((round2?.childNode(withName: "NotSelecetedG1R\(i)") as! SKSpriteNode, false, false))
        }
        buttonsR2[11].IsAnswer = true
        
        for i in 1 ... 30 {
            buttonsR3.append((round3?.childNode(withName: "NotSelecetedG1R\(i)") as! SKSpriteNode, false, false))
        }
        buttonsR3[16].IsAnswer = true
        
        // self.view?.presentScene(GameScene(fileNamed: "GameScene"), transition: SKTransition.fade(withDuration: TimeInterval(1.5))) -> apresenta a scene
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        // Round 1
        if self.contains(round1) {
            for (index, button) in buttonsR1.enumerated() {
                if button.Sprite.contains(self.convert(pos, to: round1)) {
                    button.Sprite.texture = SKTexture(imageNamed: "selectedGame1")
                    buttonsR1[index] = (button.Sprite, !button.Selected, button.IsAnswer)
                    for (indexAux, buttonAux) in buttonsR1.enumerated() {
                        if index == indexAux {
                            continue
                        }
                        buttonAux.Sprite.texture = SKTexture(imageNamed: "notSelectedGame1")
                        buttonsR1[indexAux] = (buttonAux.Sprite, false, buttonAux.IsAnswer)
                    }
                }
                if button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    labelResult.text = "ACERTOU!"
                    round1.removeFromParent()
                    calculating.removeFromParent()
                    confirmGame.removeFromParent()
                    removeSprite = scared
                    addChild(nextGame)
                    addChild(scared)
                    nextScene = round2
                }
                if !button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    labelResult.text = "FAIL!"
                    round1.removeFromParent()
                    calculating.removeFromParent()
                    confirmGame.removeFromParent()
                    removeSprite = happy
                    addChild(nextGame)
                    addChild(happy)
                    nextScene = round2
                }
            }
        }

        // Round 2
        if self.contains(round2) {
            for (index, button) in buttonsR2.enumerated() {
                if button.Sprite.contains(self.convert(pos, to: round2)) {
                    button.Sprite.texture = SKTexture(imageNamed: "selectedGame1")
                    buttonsR2[index] = (button.Sprite, !button.Selected, button.IsAnswer)
                    for (indexAux, buttonAux) in buttonsR2.enumerated() {
                        if index == indexAux {
                            continue
                        }
                        buttonAux.Sprite.texture = SKTexture(imageNamed: "notSelectedGame1")
                        buttonsR2[indexAux] = (buttonAux.Sprite, false, buttonAux.IsAnswer)
                    }
                }
                if button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    labelResult.text = "ACERTOU!"
                    round2.removeFromParent()
                    calculating.removeFromParent()
                    confirmGame.removeFromParent()
                    removeSprite = okay
                    addChild(nextGame)
                    addChild(okay)
                    nextScene = round3
                }
                if !button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    labelResult.text = "FAIL!"
                    round2.removeFromParent()
                    calculating.removeFromParent()
                    confirmGame.removeFromParent()
                    removeSprite = happy
                    addChild(nextGame)
                    addChild(happy)
                    nextScene = round3
                }
            }
        }

        // Round 3
        if self.contains(round3) {
            for (index, button) in buttonsR3.enumerated() {
                if button.Sprite.contains(self.convert(pos, to: round3)) {
                    button.Sprite.texture = SKTexture(imageNamed: "selectedGame1")
                    buttonsR3[index] = (button.Sprite, !button.Selected, button.IsAnswer)
                    for (indexAux, buttonAux) in buttonsR3.enumerated() {
                        if index == indexAux {
                            continue
                        }
                        buttonAux.Sprite.texture = SKTexture(imageNamed: "notSelectedGame1")
                        buttonsR3[indexAux] = (buttonAux.Sprite, false, buttonAux.IsAnswer)
                    }
                }
                if button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    labelResult.text = "ACERTOU!"
                    round3.removeFromParent()
                    calculating.removeFromParent()
                    confirmGame.removeFromParent()
                    removeSprite = angry
                    addChild(nextGame)
                    addChild(angry)
                    nextScene = nil
                }
                if !button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    labelResult.text = "FAIL!"
                    round3.removeFromParent()
                    calculating.removeFromParent()
                    confirmGame.removeFromParent()
                    removeSprite = happy
                    addChild(nextGame)
                    addChild(happy)
                    nextScene = nil
                }
            }
        }
        
        // Apresenta próxima cena
        if nextGame.contains(pos) {
            if nextScene == nil {
                let scene2 = GameScene2(fileNamed: "GameScene2")!
                scene2.scaleMode = .aspectFill
                self.view?.presentScene(scene2)
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
