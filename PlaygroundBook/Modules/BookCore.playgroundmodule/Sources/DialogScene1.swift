import Foundation
import SpriteKit

public class DialogScene1: SKScene {
    
    var happy, thinking, desesperate, normal, macintosh, flash, dialogBar: SKNode!
    var labelDialog: SKLabelNode!
    var dialogs = ["Oi! Eu sou o Cyber! Eu gosto muito de resolver problemas computacionais!",
                   "Você sabia que existem problemas de cálculo que não tem solução? São chamados problemas indecidíveis",
                   "Mesmo que muitos pensem que um dia nós iremos resolvê-los, talvez não conseguiremos",
                   "Existem alguns problemas que já resolvemos ou pelo ainda estamos tentando",
                   "Meu primo famoso, o Toch, já demorou 18 meses para resolver um deles!",
                   "Acredite ou não, foi um dos mais rápidos!",
                   "Esses são os problemas intratáveis. E para você poder entender melhor, irei propor dois desafios"]
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
