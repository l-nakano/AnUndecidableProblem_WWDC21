import Foundation
import SpriteKit

public class DialogScene1: SKScene {
    
    var happy, thinking, desesperate, normal, macintosh, flash, dialogBar: SKNode!
    var labelDialog: SKLabelNode!
    var dialogs = ["Hi! I'm Cyber! I love solving computer problems!",
                   "Do you know there are calculus problems that are unsolved? They are called indecidable problems",
                   "Even if many people think that one day we'lll solve them, maybe we'll not be able to",
                   "There are some problems that we already solve or we are still trying to",
                   "My famous cousin, Toch, took 18 months to solve one of them!",
                   "Believe or not, he was one of the fastest!",
                   "Those are intractable problems. To help you to understand better, I'll propose two challenges"]
    var allScenes = [[SKNode]]()
    
    override public func didMove(to view: SKView) {
        happy = self.childNode(withName: "feliz")
        thinking = self.childNode(withName: "pensativo")
        desesperate = self.childNode(withName: "desesperado")
        normal = self.childNode(withName: "normal")
        macintosh = self.childNode(withName: "macintosh")
        flash = self.childNode(withName: "flash")
        dialogBar = self.childNode(withName: "barraFala")
        labelDialog = self.childNode(withName: "labelFala") as? SKLabelNode
        thinking.removeFromParent()
        desesperate.removeFromParent()
        normal.removeFromParent()
        macintosh.removeFromParent()
        flash.removeFromParent()
        labelDialog.text = dialogs.first
        allScenes = [[happy], [thinking], [desesperate], [normal], [happy, macintosh], [happy, flash], [normal], [happy]]
    }
    
    @objc static override public var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if dialogBar.contains(pos) {
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
