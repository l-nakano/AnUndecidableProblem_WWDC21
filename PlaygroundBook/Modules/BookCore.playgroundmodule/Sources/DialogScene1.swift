import Foundation
import SpriteKit

public class DialogScene1: SKScene {
    
    var happy, thinking, desesperate, normal, macintosh, flash, janelaiOS, dialogBar: SKNode!
    var labelDialog: SKLabelNode!
    var dialogs = ["Hi! I'm Cyber, I love solving computer problems!",
                   "Do you know there are calculus problems that are unsolved? They are called undecidable problems.",
                   "Even if many people think that one day we'll solve them, maybe we'll not be able to.",
                   "There are some problems that we already solve or we are still trying to.",
                   "My famous cousin, Toch, took 18 months to solve one of them!",
                   "Believe or not, he was one of the fastest!",
                   "Those are intractable problems. To help you to understand better, I'll propose two challenges."]
    var allScenes = [[SKNode]]()
    
    override public func didMove(to view: SKView) {
        happy = self.childNode(withName: "feliz")
        thinking = self.childNode(withName: "pensativo")
        desesperate = self.childNode(withName: "desesperado")
        normal = self.childNode(withName: "normal")
        macintosh = self.childNode(withName: "macintosh")
        flash = self.childNode(withName: "flash")
        dialogBar = self.childNode(withName: "barraFala")
        janelaiOS = self.childNode(withName: "janelaiOS")
        labelDialog = self.childNode(withName: "labelFala") as? SKLabelNode
        happy.removeFromParent()
        thinking.removeFromParent()
        desesperate.removeFromParent()
        normal.removeFromParent()
        macintosh.removeFromParent()
        flash.removeFromParent()
        janelaiOS.removeFromParent()
        labelDialog.removeFromParent()
        dialogBar.removeFromParent()
        labelDialog.text = ""
        
        allScenes = [[happy], [thinking], [desesperate], [normal], [janelaiOS, macintosh, happy], [janelaiOS, flash, happy], [normal], [happy]]
        
        let appearCyber = SKAction.run {
            self.happy.position = CGPoint(x: 0, y: 0)
            self.happy.zPosition = 1
            self.addChild(self.happy)
        }
        let moveCyber = SKAction.run {
            self.happy.run(SKAction.move(to: CGPoint(x: -363.504, y: -303.143), duration: 1))
        }
        let appearDialog = SKAction.run {
            self.labelDialog.alpha = 0
            self.dialogBar.alpha = 0
            self.addChild(self.dialogBar)
            self.addChild(self.labelDialog)
            self.labelDialog.run(SKAction.fadeIn(withDuration: 1))
            self.dialogBar.run(SKAction.fadeIn(withDuration: 1))
            GSAudio.sharedInstance.playSound(soundFileName: "Tink", fileExtension: "aiff")
        }
        let initialSequence = [SKAction.wait(forDuration: 2), appearCyber, SKAction.wait(forDuration: 1), moveCyber, SKAction.wait(forDuration: 1.3), appearDialog]
        self.run(SKAction.sequence(initialSequence))
        for label in dialogs.first! {
            labelDialog.text! += "\(label)"
            RunLoop.current.run(until: Date()+0.03)
        }
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if self.contains(pos) {
            if self.contains(dialogBar)  {
                if dialogs.count == 1 {
                    let gameScene1 = GameScene1(fileNamed: "GameScene1")!
                    gameScene1.scaleMode = .aspectFit
                    self.view?.presentScene(gameScene1)
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
                            myScene.run(SKAction.scale(to: 0.6, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: 324.9, y: 256.036), duration: 0.5))
                            GSAudio.sharedInstance.playSound(soundFileName: "Funk", fileExtension: "aiff")
                        case "macintosh":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 0.35, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: 324.9, y: 240), duration: 0.5))
                        case "flash":
                            myScene.alpha = 0
                            myScene.setScale(0.0)
                            myScene.position = CGPoint(x: -359, y: -256)
                            addChild(myScene)
                            myScene.run(SKAction.scale(to: 0.35, duration: 0.5))
                            myScene.run(SKAction.fadeIn(withDuration: 0.3))
                            myScene.run(SKAction.move(to: CGPoint(x: 329.7, y: 239.825), duration: 0.5))
                        default:
                            addChild(myScene)
                        }
                    }
                    GSAudio.sharedInstance.playSound(soundFileName: "Tink", fileExtension: "aiff")
                    labelDialog.text = ""
                    for label in dialogs.first! {
                        labelDialog.text! += "\(label)"
                        RunLoop.current.run(until: Date()+0.03)
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
        
    }
}
