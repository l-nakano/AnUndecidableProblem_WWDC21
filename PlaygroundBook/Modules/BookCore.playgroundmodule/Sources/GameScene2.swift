//
//  GameScene2.swift
//  BookCore
//
//  Created by Lucas Yoshio Nakano on 11/04/21.
//

import Foundation
import SpriteKit

public class GameScene2: SKScene {
    
    var itemsRound1: [(Sprite: (Box: SKSpriteNode, Shadow: SKSpriteNode), isAnswer: Bool, Selected: Bool)]! = []
    var itemsRound2: [(Sprite: (Box: SKSpriteNode, Shadow: SKSpriteNode), isAnswer: Bool, Selected: Bool)]! = []
    var itemsRound3: [(Sprite: (Box: SKSpriteNode, Shadow: SKSpriteNode), isAnswer: Bool, Selected: Bool)]! = []
    var round1, round2, round3, nextScene, calculating, relived, totalRelived, happy, rascal, normal, normalSfried, sFried, fried, desesperate, graph, dialogBar, rAnswer, wAnswer: SKNode!
    var confirmGame: SKSpriteNode!
    var labelDialog: SKLabelNode!
    var allScenesDic = [String:[SKNode]]()
    var dialogs = ["Agora vou te desafiar para um mais complicado! Ele é conhecido como problema da mochila",
                   "Tenho 4 caixas que são muito pesadas para a minha mochila!",
                   "Preciso levar a maior quantidade de caixas e o maior valor ($), sem ultrapassar a capacidade",
                   "Gosto de desafios! Vou lançar mais um para resolvermos",
                   "Uff! Quase não consegui! Já estou sentindo minha temperatura aumentar! Como você se sente?",
                   "Ok, prometo que esse é o último! Vamos dar uma turbinada!",
                   "Se antes eu estava quente, agora estou fervendo! Por que tive essa ideia de desafio?",
                   "Foi difícil né? A cada aumento de itens o problema ficava muito mais complexo",
                   "Esse é o gráfico do tempo que eu demoro para resolver este problema",
                   "Esse é um dos motivos desse problema ser considerado \"difícil\", ou como dizem por ai, de complexidade NP"]
    var dialogsGames = ["round1Ok": "Já tive que ocupar boa parte da minha memória pra resolver este, mas consegui também!",
                        "round1Nok": "Você não selecinou as caixas certas. Pense no valor por Kg"]
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
        totalRelived = self.childNode(withName: "alivioTotal")
        graph = self.childNode(withName: "grafico")
        rAnswer = self.childNode(withName: "acertou")
        wAnswer = self.childNode(withName: "errou")
        desesperate = self.childNode(withName: "desesperado")
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
        totalRelived.removeFromParent()
        graph.removeFromParent()
        rAnswer.removeFromParent()
        wAnswer.removeFromParent()
        desesperate.removeFromParent()
        confirmGame = self.childNode(withName: "Confirm") as? SKSpriteNode
        confirmGame.removeFromParent()
        labelDialog = self.childNode(withName: "labelFala") as? SKLabelNode
        
        labelDialog.text = dialogs.first
        currentRound = ""

        allScenesDic = ["preGame": [rascal, dialogBar, labelDialog], "knapProblem": [desesperate, dialogBar, labelDialog],
                        "gameInit": [normal, dialogBar, labelDialog], "round1": [round1, calculating, confirmGame, dialogBar, labelDialog],
                        "round1Ok": [dialogBar, labelDialog, relived, rAnswer], "round1Nok": [dialogBar, labelDialog, normal, wAnswer],
                        "preRound2": [happy, dialogBar, labelDialog], "round2": [round2, calculating, confirmGame, dialogBar, labelDialog],
                        "posRound2": [sFried, dialogBar, labelDialog], "preRound3": [normalSfried, dialogBar, labelDialog],
                        "round3": [round3, calculating, confirmGame, dialogBar, labelDialog], "posRound3": [fried, dialogBar, labelDialog],
                        "posGame": [totalRelived, dialogBar, labelDialog], "graph": [happy, dialogBar, labelDialog, graph],
                        "npProblem":[happy, dialogBar, labelDialog]]
        allScenesString = ["preGame", "knapProblem", "gameInit", "round1", "preRound2", "round2", "posRound2", "preRound3", "round3", "posRound3", "posGame", "graph", "npProblem"]
        
        for i in 1 ... 4 {
            if i == 1 || i == 2 || i == 3 {
                itemsRound1.append(((round1?.childNode(withName: "item\(i)") as! SKSpriteNode, round1?.childNode(withName: "item\(i)Sombra") as! SKSpriteNode), true, false))
            }
            else {
                itemsRound1.append(((round1?.childNode(withName: "item\(i)") as! SKSpriteNode, round1?.childNode(withName: "item\(i)Sombra") as! SKSpriteNode), false, false))
            }
        }

        for i in 1 ... 5 {
            if i == 1 || i == 2 || i == 5 {
                itemsRound2.append(((round2?.childNode(withName: "item\(i)") as! SKSpriteNode, round2?.childNode(withName: "item\(i)Sombra") as! SKSpriteNode), true, false))
            }
            else {
                itemsRound2.append(((round2?.childNode(withName: "item\(i)") as! SKSpriteNode, round2?.childNode(withName: "item\(i)Sombra") as! SKSpriteNode), false, false))
            }
        }

        for i in 1 ... 6 {
            if i == 1 || i == 4 || i == 6 {
                itemsRound3.append(((round3?.childNode(withName: "item\(i)") as! SKSpriteNode, round3?.childNode(withName: "item\(i)Sombra") as! SKSpriteNode), true, false))
            }
            else {
                itemsRound3.append(((round3?.childNode(withName: "item\(i)") as! SKSpriteNode, round3?.childNode(withName: "item\(i)Sombra") as! SKSpriteNode), false, false))
            }
        }
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
        if dialogBar.contains(pos) && !self.contains(round1) && !self.contains(round2) && !self.contains(round3) {
            if dialogs.count == 1 {
                let dialogScene2 = DialogScene2(fileNamed: "DialogScene2")!
                dialogScene2.scaleMode = .aspectFit
                self.view?.presentScene(dialogScene2)
            }
            else {
                if dialogsGames.keys.contains(currentRound) {
                    for myScene in allScenesDic[currentRound]! {
                        myScene.removeFromParent()
                    }
                    for myScene in allScenesDic[allScenesString.first!]! {
                        addChild(myScene)
                    }
                    labelDialog.text = dialogs.first
                    currentRound = ""
                }
                else {
                    for myScene in allScenesDic[allScenesString.first!]! {
                        myScene.removeFromParent()
                    }
                    if self.contains(rAnswer) {
                        rAnswer.removeFromParent()
                    }
                    if self.contains(wAnswer) {
                        wAnswer.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic[allScenesString.first!]! {
                        addChild(myScene)
                    }
                    if !self.contains(round1) && !self.contains(round2) && !self.contains(round3) {
                        dialogs.remove(at: 0)
                    }
                    labelDialog.text = dialogs.first
                }
            }
        }
        
        if self.contains(round1) {
            for (index, item) in itemsRound1.enumerated() {
                if item.Sprite.Box.contains(self.convert(pos, to: round1)) {
                    if item.Selected {
                        item.Sprite.Shadow.alpha = 0
                        item.Sprite.Box.setScale(0.3)
                        itemsRound1[index].Selected = false
                    }
                    else {
                        item.Sprite.Shadow.alpha = 1
                        item.Sprite.Box.setScale(0.35)
                        itemsRound1[index].Selected = true
                    }
                }
            }
            if confirmGame.contains(pos) {
                for item in itemsRound1 {
                    if item.Selected != item.isAnswer {
                        for myScene in allScenesDic[allScenesString.first!]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic["round1Nok"]! {
                            addChild(myScene)
                        }
                        dialogs.remove(at: 0)
                        labelDialog.text = dialogsGames["round1Nok"]
                        currentRound = "round1Nok"
                        break
                    }
                    if item.Selected == item.isAnswer && item.Sprite == itemsRound1.last!.Sprite {
                        for myScene in allScenesDic[allScenesString.first!]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic["round1Ok"]! {
                            addChild(myScene)
                        }
                        dialogs.remove(at: 0)
                        labelDialog.text = dialogsGames["round1Ok"]
                        currentRound = "round1Ok"
                    }
                }
            }
        }
        
        if self.contains(round2) {
            for (index, item) in itemsRound2.enumerated() {
                if item.Sprite.Box.contains(self.convert(pos, to: round2)) {
                    if item.Selected {
                        item.Sprite.Shadow.alpha = 0
                        item.Sprite.Box.setScale(0.3)
                        itemsRound2[index].Selected = false
                    }
                    else {
                        item.Sprite.Shadow.alpha = 1
                        item.Sprite.Box.setScale(0.35)
                        itemsRound2[index].Selected = true
                    }
                }
            }
            if confirmGame.contains(pos) {
                for item in itemsRound2 {
                    if item.Selected != item.isAnswer {
                        for myScene in allScenesDic[allScenesString.first!]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic[allScenesString.first!]! {
                            addChild(myScene)
                        }
                        dialogs.remove(at: 0)
                        labelDialog.text = dialogs.first
                        addChild(wAnswer)
                        break
                    }
                    if item.Selected == item.isAnswer && item.Sprite == itemsRound2.last!.Sprite {
                        for myScene in allScenesDic[allScenesString.first!]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic[allScenesString.first!]! {
                            addChild(myScene)
                        }
                        dialogs.remove(at: 0)
                        labelDialog.text = dialogs.first
                        addChild(rAnswer)
                    }
                }
            }
        }
        
        if self.contains(round3) {
            for (index, item) in itemsRound3.enumerated() {
                if item.Sprite.Box.contains(self.convert(pos, to: round3)) {
                    if item.Selected {
                        item.Sprite.Shadow.alpha = 0
                        item.Sprite.Box.setScale(0.3)
                        itemsRound3[index].Selected = false
                    }
                    else {
                        item.Sprite.Shadow.alpha = 1
                        item.Sprite.Box.setScale(0.35)
                        itemsRound3[index].Selected = true
                    }
                }
            }
            if confirmGame.contains(pos) {
                for item in itemsRound3 {
                    if item.Selected != item.isAnswer {
                        for myScene in allScenesDic[allScenesString.first!]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic[allScenesString.first!]! {
                            addChild(myScene)
                        }
                        dialogs.remove(at: 0)
                        labelDialog.text = dialogs.first
                        addChild(wAnswer)
                        break
                    }
                    if item.Selected == item.isAnswer && item.Sprite == itemsRound3.last!.Sprite {
                        for myScene in allScenesDic[allScenesString.first!]! {
                            myScene.removeFromParent()
                        }
                        allScenesString.remove(at: 0)
                        for myScene in allScenesDic[allScenesString.first!]! {
                            addChild(myScene)
                        }
                        dialogs.remove(at: 0)
                        labelDialog.text = dialogs.first
                        addChild(rAnswer)
                    }
                }
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
