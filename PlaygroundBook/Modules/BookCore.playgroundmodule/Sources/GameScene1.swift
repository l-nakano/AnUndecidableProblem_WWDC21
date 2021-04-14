import Foundation
import SpriteKit

public class GameScene1: SKScene {
    
    var buttonsR1 = [(Sprite: SKSpriteNode, Selected: Bool, IsAnswer: Bool)]()
    var buttonsR2 = [(Sprite: SKSpriteNode, Selected: Bool, IsAnswer: Bool)]()
    var buttonsR3 = [(Sprite: SKSpriteNode, Selected: Bool, IsAnswer: Bool)]()
    var confirmGame: SKSpriteNode!
    var round1, round2, round3, calculating, scared, happy, okay, angry, normal, neutral, dialogBar: SKNode!
    var labelResult, labelDialog: SKLabelNode!
    var dialogs = ["Aqui tem uma sequência com 10 números, encontre o número 67!",
                   "Vou deixar um pouco mais difícil, está preparado?",
                   "Último desafio de encontrar números! Vamos se eu consigo dessa vez",
                   "Você resolveu bem rápido! Poderia deixar eu ganhar uma vez..."]
    var dialogsGames = ["round1Ok": "Calma lá! Eu nem cheguei na metade ainda! Você conseguiu resolver mais rápido do que eu!",
                        "round1Nok": "Vou te dar uma dica! Os números estão ordenados em ordem crescente",
                        "round2Ok": "Okay... Nem comecei ainda... Acho que você conseguiu entender o que eu estava dizendo",
                        "round2Nok": "Mais uma dica! Olhe atentamente, não tenha pressa",
                        "round3Ok": "Você resolve bem rápido! Poderia deixar eu ganhar uma vez...",
                        "round3Nok": "Tudo bem, foi só um deslize!"]
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
        round1.removeFromParent()
        round2.removeFromParent()
        round3.removeFromParent()
        scared.removeFromParent()
        calculating.removeFromParent()
        okay.removeFromParent()
        angry.removeFromParent()
        normal.removeFromParent()
        neutral.removeFromParent()
        confirmGame = self.childNode(withName: "Confirm") as? SKSpriteNode
        confirmGame.removeFromParent()
        labelResult = self.childNode(withName: "LabelResult") as? SKLabelNode
        labelDialog = self.childNode(withName: "labelFala") as? SKLabelNode
        labelDialog.text = dialogs.first
        currentRound = ""
        
        allScenesDic = ["preGame": [happy, dialogBar, labelDialog], "round1": [calculating, round1, confirmGame], "round1Ok" : [scared, dialogBar, labelDialog],
                        "round1Nok": [happy, dialogBar, labelDialog], "preRound2": [normal, dialogBar, labelDialog], "round2": [calculating, round2, confirmGame],
                        "round2Ok": [okay, dialogBar, labelDialog], "round2Nok": [happy, dialogBar, labelDialog], "preRound3": [neutral, dialogBar, labelDialog],
                        "round3": [calculating, round3, confirmGame], "round3Ok": [angry, dialogBar, labelDialog], "round3Nok": [happy, dialogBar, labelDialog]]
        allScenesString = ["preGame", "round1", "preRound2", "round2", "preRound3", "round3"]
        
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
        
        if dialogBar.contains(pos) {
            if currentRound == "round3Ok" || currentRound == "round3Nok" {
                let scene2 = GameScene2(fileNamed: "GameScene2")!
                scene2.scaleMode = .aspectFit
                self.view?.presentScene(scene2)
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
                }
            }
        }
        
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
                if !button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    labelResult.text = "FAIL!"
                    for myScene in allScenesDic[allScenesString[0]]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic["round1Nok"]! {
                        addChild(myScene)
                    }
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
                    labelResult.text = "ACERTOU!"
                    for myScene in allScenesDic[allScenesString[0]]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic["round2Ok"]! {
                        addChild(myScene)
                    }
                    labelDialog.text = dialogsGames["round2Ok"]
                    currentRound = "round2Ok"
                }
                if !button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    labelResult.text = "FAIL!"
                    for myScene in allScenesDic[allScenesString[0]]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic["round2Nok"]! {
                        addChild(myScene)
                    }
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
                    labelResult.text = "ACERTOU!"
                    for myScene in allScenesDic[allScenesString[0]]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic["round3Ok"]! {
                        addChild(myScene)
                    }
                    labelDialog.text = dialogsGames["round3Ok"]
                    currentRound = "round3Ok"
                }
                if !button.IsAnswer && button.Selected && confirmGame.contains(pos) {
                    labelResult.text = "FAIL!"
                    for myScene in allScenesDic[allScenesString[0]]! {
                        myScene.removeFromParent()
                    }
                    allScenesString.remove(at: 0)
                    for myScene in allScenesDic["round3Nok"]! {
                        addChild(myScene)
                    }
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
