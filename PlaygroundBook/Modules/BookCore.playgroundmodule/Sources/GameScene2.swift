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
    var round1, round2, round3, nextScene, calculating, relived, totalRelived, happy, rascal, normal, normalSfried, sFried, fried, desesperate, graph, dialogBar, rAnswer, wAnswer, iOSwindow, iOSwindowR1, graphWindow: SKNode!
    var confirmGame: SKSpriteNode!
    var labelDialog: SKLabelNode!
    var allScenesDic = [String:[SKNode]]()
    var dialogs = ["Now we'll face a more complicated challenge! It is known as \"Knapsack Problem\".",
                   "I have 4 boxes that are too heavy for my knapsack!",
                   "I have to get as many boxes as possible and the higher value ($), without exceeding the capacity.",
                   "I have to get as many boxes as possible and the higher value ($), without exceeding the capacity.",
                   "As I already said, I like challenges! I'll get another one for us!",
                   "I have to get as many boxes as possible and the higher value ($), without exceeding the capacity.",
                   "Uff! I almost didn't get it! I'm feeling my temperature raise! How do you feel?",
                   "Ok, I promise that one will be the last one! Let's boost that challenge!",
                   "I have to get as many boxes as possible and the higher value ($), without exceeding the capacity.",
                   "If I was hot, now I'm boiling! Why did I have this idea?",
                   "That was hard, wasn't it? If I increase the number of items, the challenge became more complex.",
                   "This is the graph of the time it takes me to solve this challenge.",
                   "That's one reason that make the knapsack problem \"hard\", or how they say around, complex class NP."]
    var dialogsGames = ["round1Ok": "I had to occupy good part of my memory to solve it, but I got it either!",
                        "round1Nok": "You didn't select the right boxes. Think in the value ($) per lb."]
    var allScenesString = [String]()
    var currentRound: String!
    var graphShapeNode: [SKShapeNode]! = []
    var re = 0.0
    
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
        graph = self.childNode(withName: "grafico2")
        rAnswer = self.childNode(withName: "acertou")
        wAnswer = self.childNode(withName: "errou")
        desesperate = self.childNode(withName: "desesperado")
        iOSwindow = self.childNode(withName: "janelaiOS")
        iOSwindowR1 = self.childNode(withName: "janelaiOSm2")
        graphWindow = self.childNode(withName: "janelaGrafico")
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
        iOSwindow.removeFromParent()
        iOSwindowR1.removeFromParent()
        graphWindow.removeFromParent()
        confirmGame = self.childNode(withName: "Confirm") as? SKSpriteNode
        confirmGame.removeFromParent()
        labelDialog = self.childNode(withName: "labelFala") as? SKLabelNode
        
        labelDialog.text = dialogs.first
        currentRound = ""

        allScenesDic = ["preGame": [dialogBar, labelDialog, rascal], "knapProblem": [dialogBar, labelDialog, desesperate],
                        "gameInit": [dialogBar, labelDialog, normal], "npProblem":[dialogBar, labelDialog, happy],
                        "round1": [iOSwindowR1, round1, confirmGame, dialogBar, labelDialog, calculating],
                        "round1Ok": [dialogBar, labelDialog, relived, rAnswer], "round1Nok": [dialogBar, labelDialog, normal, wAnswer],
                        "preRound2": [dialogBar, labelDialog, happy], "round2": [iOSwindow, round2, confirmGame, dialogBar, labelDialog, calculating],
                        "posRound2": [dialogBar, labelDialog, sFried], "preRound3": [dialogBar, labelDialog, normalSfried],
                        "round3": [iOSwindow, round3, confirmGame, dialogBar, labelDialog, calculating], "posRound3": [dialogBar, labelDialog, fried],
                        "posGame": [dialogBar, labelDialog, totalRelived], "graph": [dialogBar, labelDialog, graphWindow, graph, happy],]
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
        
        if self.contains(pos) && !self.contains(round1) && !self.contains(round2) && !self.contains(round3) && (!self.contains(graph) || re >= 8.65) {
            if dialogs.count == 1 {
                let dialogScene2 = DialogScene2(fileNamed: "DialogScene2")!
                dialogScene2.scaleMode = .aspectFit
                self.view?.presentScene(dialogScene2)
            }
            else {
                if !graphShapeNode.isEmpty {
                    for shapeNode in graphShapeNode {
                        shapeNode.removeFromParent()
                    }
                    graphShapeNode.removeAll()
                }
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
                        switch myScene.name {
                        case "Round1":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: -475.191, y: 231.764), duration: 0.5))
                        case "Round2":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: -314.062, y: 241.525), duration: 0.5))
                        case "Round3":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: -314.062, y: 241.524), duration: 0.5))
                        case "janelaiOS":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: 0.4, y: 196.946), duration: 0.5))
                        case "janelaiOSm2":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: -11.196, y: 194.291), duration: 0.5))
                        case "janelaGrafico":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1.25, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: 0.4, y: 196.446), duration: 0.5))
                        case "grafico2":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 0.7, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: 0.4, y: 156.09), duration: 0.5))
                        case "Confirm":
                            if allScenesString.contains("round1") {
                                myScene.alpha = 0
                                myScene.setScale(0.0)
                                myScene.position = CGPoint(x: -359, y: -256)
                                addChild(myScene)
                                myScene.run(SKAction.scale(to: 1, duration: 0.5))
                                myScene.run(SKAction.fadeIn(withDuration: 0.3))
                                myScene.run(SKAction.move(to: CGPoint(x: 280.121, y: 26.8), duration: 0.5))
                            } else {
                                myScene.alpha = 0
                                myScene.setScale(0.0)
                                myScene.position = CGPoint(x: -359, y: -256)
                                addChild(myScene)
                                myScene.run(SKAction.scale(to: 1, duration: 0.5))
                                myScene.run(SKAction.fadeIn(withDuration: 0.3))
                                myScene.run(SKAction.move(to: CGPoint(x: 431.895, y: 36.561), duration: 0.5))
                            }
                        default:
                            addChild(myScene)
                        }
                    }
                    dialogs.remove(at: 0)
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
        if self.contains(graph) && graph.position.x >= 0.4 && re < 8.65 {
            let circle = SKShapeNode(circleOfRadius: 5)
            circle.fillColor = .red
            circle.strokeColor = .red
            circle.position = CGPoint(x: re*10 - 74, y: pow(2.0, re) - 45)
            graphShapeNode.append(circle)
            addChild(graphShapeNode.last!)
            re += 0.02
        }
    }
}
