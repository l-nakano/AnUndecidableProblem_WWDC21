import Foundation
import SpriteKit

public class GameScene1: SKScene {
    
    var buttonsR1 = [(Sprite: SKSpriteNode, Selected: Bool, IsAnswer: Bool)]()
    var buttonsR2 = [(Sprite: SKSpriteNode, Selected: Bool, IsAnswer: Bool)]()
    var buttonsR3 = [(Sprite: SKSpriteNode, Selected: Bool, IsAnswer: Bool)]()
    var confirmGame: SKSpriteNode!
    var round1, round2, round3, calculating, scared, happy, okay, angry, normal, neutral, graph, dialogBar, rAnswer, wAnswer, iOSwindow: SKNode!
    var labelDialog: SKLabelNode!
    var dialogs = ["I need to find a number I lost in my memory",
                   "I'll show a sequence of numbers, can you find the 67?",
                   "I'll let it a little harder, are you ready?",
                   "Last challenge of finding the number! Let's see if I can do it this time",
                   "Did you notice that it makes no difference to you when I increase the quantity of numbers?",
                   "This is the graph of the time it takes me to solve this problem",
                   "That's why this problem is considered \"easy\", or complex class P"]
    var dialogsGames = ["round1Ok": "Calm down! I didn't even reach the half! You solved it much faster than I did!",
                        "round1Nok": "It wasn't the 67. The numbers are in ascending order",
                        "round2Ok": "Okay... You're really fast... I think you got what I'm talking about",
                        "round2Nok": "That wasn't the right answer. Note the pattern and don't be hurry",
                        "round3Ok": "You solved it too fast! You should let me win once...",
                        "round3Nok": "Not the answer, but it's ok, it was just a slip!"]
    var allScenesDic = [String:[SKNode]]()
    var allScenesString = [String]()
    var currentRound: String!
    
    override public func didMove(to view: SKView) {
        round1 = self.childNode(withName: "Round1")
        round2 = self.childNode(withName: "Round2")
        round3 = self.childNode(withName: "Round3")
        calculating = self.childNode(withName: "calculando")
        scared = self.childNode(withName: "assustado")
        happy = self.childNode(withName: "feliz")
        okay = self.childNode(withName: "okay")
        angry = self.childNode(withName: "pistola")
        dialogBar = self.childNode(withName: "barraFala")
        normal = self.childNode(withName: "normal")
        neutral = self.childNode(withName: "neutro")
        graph = self.childNode(withName: "grafico")
        rAnswer = self.childNode(withName: "acertou")
        wAnswer = self.childNode(withName: "errou")
        iOSwindow = self.childNode(withName: "janelaiOS")
        round1.removeFromParent()
        round2.removeFromParent()
        round3.removeFromParent()
        scared.removeFromParent()
        calculating.removeFromParent()
        okay.removeFromParent()
        angry.removeFromParent()
        happy.removeFromParent()
        neutral.removeFromParent()
        graph.removeFromParent()
        rAnswer.removeFromParent()
        wAnswer.removeFromParent()
        iOSwindow.removeFromParent()
        confirmGame = self.childNode(withName: "Confirm") as? SKSpriteNode
        confirmGame.removeFromParent()
        labelDialog = self.childNode(withName: "labelFala") as? SKLabelNode
        labelDialog.text = dialogs.first
        currentRound = ""
        
        allScenesDic = ["preScene": [dialogBar, labelDialog, normal], "preGame": [dialogBar, labelDialog, happy],
                        "round1": [iOSwindow, round1, confirmGame, dialogBar, labelDialog, calculating],
                        "round2": [iOSwindow, round2, confirmGame, dialogBar, labelDialog, calculating],
                        "round3": [iOSwindow, round3, confirmGame, dialogBar, labelDialog, calculating],
                        "round2Ok": [dialogBar, labelDialog, okay, rAnswer], "round1Ok" : [dialogBar, labelDialog, scared, rAnswer],
                        "round1Nok": [dialogBar, labelDialog, normal, wAnswer], "preRound2": [dialogBar, labelDialog, normal],
                        "round2Nok": [dialogBar, labelDialog, normal, wAnswer], "preRound3": [dialogBar, labelDialog, neutral],
                        "round3Ok": [dialogBar, labelDialog, angry, rAnswer], "round3Nok": [dialogBar, labelDialog, normal, wAnswer],
                        "posGame": [dialogBar, labelDialog, normal], "graph": [dialogBar, graph, labelDialog, happy],
                        "Pproblem": [dialogBar, labelDialog, happy]]
        allScenesString = ["preScene", "preGame", "round1", "preRound2", "round2", "preRound3", "round3", "posGame", "graph", "Pproblem"]
        
        for i in 1 ... 10 {
            buttonsR1.append((round1?.childNode(withName: "NotSelecetedG1R\(i)") as! SKSpriteNode, false, false))
        }
        buttonsR1[6].IsAnswer = true
        buttonsR1[0].Sprite.isUserInteractionEnabled = false
        
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
        
        if self.contains(pos) && !self.contains(round1) && !self.contains(round2) && !self.contains(round3) {
            if dialogs.count == 1 {
                let scene2 = GameScene2(fileNamed: "GameScene2")!
                scene2.scaleMode = .aspectFit
                self.view?.presentScene(scene2)
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
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic[allScenesString.first!]! {
                        switch myScene.name {
                        case "janelaiOS":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 0.9, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: 4.4, y: 200), duration: 0.5))
                        case "Round1":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: -4.778, y: 200), duration: 0.5))
                        case "Round2":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: -4.778, y: 200), duration: 0.5))
                        case "Round3":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: -4.778, y: 200), duration: 0.5))
                        case "Confirm":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 1, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: 354.157, y: 34.209), duration: 0.5))
                        default:
                            addChild(myScene)
                        }
                    }
                    if !self.contains(round1) && !self.contains(round2) && !self.contains(round3) {
                        dialogs.remove(at: 0)
                    }
                    labelDialog.text = dialogs.first
                }
            }
        }
        
        // Round 1
        if self.contains(round1) && self.contains(confirmGame) {
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
                if !button.IsAnswer && button.Selected && confirmGame.contains(pos) {
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
                    for myScene in allScenesDic[allScenesString.first!]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic["round2Ok"]! {
                        addChild(myScene)
                    }
                    dialogs.remove(at: 0)
                    labelDialog.text = dialogsGames["round2Ok"]
                    currentRound = "round2Ok"
                }
                if !button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    for myScene in allScenesDic[allScenesString.first!]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic["round2Nok"]! {
                        addChild(myScene)
                    }
                    dialogs.remove(at: 0)
                    labelDialog.text = dialogsGames["round2Nok"]
                    currentRound = "round2Nok"
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
                    for myScene in allScenesDic[allScenesString.first!]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic["round3Ok"]! {
                        addChild(myScene)
                    }
                    dialogs.remove(at: 0)
                    labelDialog.text = dialogsGames["round3Ok"]
                    currentRound = "round3Ok"
                }
                if !button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    for myScene in allScenesDic[allScenesString.first!]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic["round3Nok"]! {
                        addChild(myScene)
                    }
                    dialogs.remove(at: 0)
                    labelDialog.text = dialogsGames["round3Nok"]
                    currentRound = "round3Nok"
                }
            }
        }
        
        // Função que exibe os textos
//            func showText(text: String, time: Double){
//                pictureBox = true
//                let hello = Label(text: text, color: #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0), font: .ChalkDuster, size: 23, name: "hello")
//                hello.position = CGPoint(x: 375, y: 1000)
//                hello.zPosition = 10
//                let helloFadeIn = SKAction.fadeIn(withDuration: 1) // Fade in para aparecer
//                let helloWait2 = SKAction.wait(forDuration: time) // Fica visível pelo tempo que foi colocado no time
//                let helloFadeOut = SKAction.fadeOut(withDuration: 0.5) // Fade out para desaparecer
//                let helloSequence = SKAction.sequence([helloFadeIn,
//                                                       helloWait2, helloFadeOut])
//                self.addChild(hello)
//                hello.run(helloSequence)
//                // Afirma que não há um texto na tela
//                pictureBox = false
//            }
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
