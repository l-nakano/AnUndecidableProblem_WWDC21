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
    var round1, round2, round3, nextScene, calculating, relived, happy, rascal, normal, normalSfried, sFried, fried, dialogBar: SKNode!
    var confirmGame: SKSpriteNode!
    var labelResult, labelDialog: SKLabelNode!
    var allScenesDic = [String:[SKNode]]()
    var dialogs = ["Agora vou te desafiar para um mais complicado!",
                   "Selecione a maior quantidade de itens, de um jeito que a mochila não estoure, mas que o valor possa ser o maior possivel",
                   "Gosto de desafios! Vou lançar mais um para resolvermos",
                   "Uff! Quase não consegui! Já estou sentindo minha temperatura aumentar! Como você se sente?",
                   "Ok, prometo que esse é o último! Vamos dar uma turbinada!",
                   "Se antes eu estava quente, agora estou fervendo! Por que tive essa ideia de desafio?"]
    var dialogsGames = ["round1Ok": "Já tive que ocupar boa parte da minha memória pra resolver este, mas consegui!",
                        "round1Nok": "Uma dica para você. Pense no valor por Kg"]
    var allScenesString = [String]()
    var currentRound: String!
    
    override public func didMove(to view: SKView) {
        round1 = self.childNode(withName: "Round1")
        round2 = self.childNode(withName: "Round2")
        round3 = self.childNode(withName: "Round3")
        calculating = self.childNode(withName: "calculando")
        relived = self.childNode(withName: "aliviado")
        happy = self.childNode(withName: "feliz")
        sFried = self.childNode(withName: "fritandoOvo")
        normalSfried = self.childNode(withName: "normalFritandoOvo")
        fried = self.childNode(withName: "ovoQueimado")
        rascal = self.childNode(withName: "malandro")
        normal = self.childNode(withName: "normal")
        dialogBar = self.childNode(withName: "barraFala")
        round1.removeFromParent()
        round2.removeFromParent()
        round3.removeFromParent()
        relived.removeFromParent()
        happy.removeFromParent()
        normalSfried.removeFromParent()
        sFried.removeFromParent()
        fried.removeFromParent()
        calculating.removeFromParent()
        normal.removeFromParent()
        confirmGame = self.childNode(withName: "Confirm") as? SKSpriteNode
        confirmGame.removeFromParent()
        labelResult = self.childNode(withName: "LabelResult") as? SKLabelNode
        labelDialog = self.childNode(withName: "labelFala") as? SKLabelNode
        
        labelDialog.text = dialogs.first
        currentRound = ""

        allScenesDic = ["preGame": [rascal, dialogBar, labelDialog], "gameInit": [normal, dialogBar, labelDialog],
                        "round1": [round1, calculating, confirmGame], "round1Ok": [dialogBar, labelDialog, relived],
                        "round1Nok": [dialogBar, labelDialog, happy], "preRound2": [happy, dialogBar, labelDialog],
                        "round2": [round2, calculating, confirmGame], "posRound2": [sFried, dialogBar, labelDialog],
                        "preRound3": [normalSfried, dialogBar, labelDialog], "round3": [round3, calculating, confirmGame],
                        "posRound3": [fried, dialogBar, labelDialog]]
        allScenesString = ["preGame", "gameInit", "round1", "preRound2", "round2", "posRound2", "preRound3", "round3", "posRound3"]
        
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
        
        if dialogBar.contains(pos) {
            if dialogs.count == 1 {
                for myScene in allScenesDic[allScenesString[0]]! {
                    myScene.removeFromParent()
                }
                dialogs.remove(at: 0)
                labelResult.text = "GGWP"
                labelResult.position = CGPoint(x: 0, y: 0)
            }
            else {
                if dialogsGames.keys.contains(currentRound) {
                    for myScene in allScenesDic[currentRound]! {
                        myScene.removeFromParent()
                    }
                    for myScene in allScenesDic[allScenesString[0]]! {
                        addChild(myScene)
                    }
                    labelDialog.text = dialogs.first
                    currentRound = ""
                }
                else {
                    for myScene in allScenesDic[allScenesString[0]]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    dialogs.remove(at: 0)
                    for myScene in allScenesDic[allScenesString[0]]! {
                        addChild(myScene)
                    }
                    labelDialog.text = dialogs.first
                }
            }
        }
        
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
                        for myScene in allScenesDic[allScenesString[0]]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic["round1Nok"]! {
                            addChild(myScene)
                        }
                        labelDialog.text = dialogsGames["round1Nok"]
                        currentRound = "round1Nok"
                        break
                    }
                    if item.Selected == item.isAnswer && item == itemsRound1.last! {
                        labelResult.text = "ACERTOU"
                        for myScene in allScenesDic[allScenesString[0]]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic["round1Ok"]! {
                            addChild(myScene)
                        }
                        labelDialog.text = dialogsGames["round1Ok"]
                        currentRound = "round1Ok"
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
                        for myScene in allScenesDic[allScenesString[0]]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic[allScenesString[0]]! {
                            addChild(myScene)
                        }
                        labelDialog.text = dialogs.first
                        break
                    }
                    if item.Selected == item.isAnswer && item == itemsRound2.last! {
                        labelResult.text = "ACERTOU"
                        for myScene in allScenesDic[allScenesString[0]]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic[allScenesString[0]]! {
                            addChild(myScene)
                        }
                        labelDialog.text = dialogs.first
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
                        for myScene in allScenesDic[allScenesString[0]]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic[allScenesString[0]]! {
                            addChild(myScene)
                        }
                        labelDialog.text = dialogs.first
                        break
                    }
                    if item.Selected == item.isAnswer && item == itemsRound3.last! {
                        labelResult.text = "ACERTOU"
                        for myScene in allScenesDic[allScenesString[0]]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic[allScenesString[0]]! {
                            addChild(myScene)
                        }
                        labelDialog.text = dialogs.first
                    }
                }
            }
        }
        
//        if nextGame.contains(pos) {
//            if nextScene == nil {
//                nextGame.removeFromParent()
//                confirmGame.removeFromParent()
//                labelResult.text = "GGWP"
//                labelResult.position = CGPoint(x: 0, y: 0)
//                removeSprite.removeFromParent()
//            }
//            else {
//                addChild(nextScene)
//                addChild(calculating)
//                addChild(confirmGame)
//                nextGame.removeFromParent()
//                removeSprite.removeFromParent()
//            }
//        }
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
