/*:
 # A Math Unsolved Problem
 
 * Note: For a better experience use this Playground in landscape.
 
 ---
 
 Are all problems in mathematics solved? The answer is **no**. There are several that remain unproven, even with most mathematicians and computer scientists having a common idea about it.
 
 One of those problems is the **P versus NP problem**. It is one of the seven *Millennium Prize Problems*, stated by Clay Mathematics Institute in 2000. If a solution is proved to be an answer to the problem, a *US$1 million prize* will be awarded by the institute to the discover(s).
 
 ---
 
 ## P versus NP problem
 
 ---
 
 This is a complex problem that involves 3 main computer science fields: *time complexity*, *deterministic/nondeterministic machine*, and *problem complexity classification*.
 * **Time complexity**, in computer science, describes the amount of computer time it takes to run an algorithm.
 * Note: The time is calculated accordingly to the number of inputs. More inputs should result in more computer time to solve the problem.
 * A **deterministic** machine is a machine where there is at most one action to be performed for any given situation. However in a **nondeterministic** machine, it may exist a set of actions for the same situation.
* For the **problem class P** (stands for *polynomial time*) there is an algorithm that can find the solution quickly (which means in *polynomial time*) when executed by a deterministic machine. On the other hand, for the **problem class NP** (stands for *nondeterministic polynomial time*) there is an algorithm that can find the solution *quickly* when executed only in a nondeterministic machine. In a deterministic one, it is not possible.
 * Note: The P vs NP problem is solved if proved, generically, that a NP problem is a P problem (P = NP), or that it is impossible to happen (P ≠ NP).
 One solution is to prove that exists an algorithm that can find a NP problem solution in polynomial time if executed by a deterministic machine.
 
 ---
 
 ## Proof consequences
 
 ---
 
 Since the P versus NP problem has consequences to other problems than in math, like in biology, philosophy, and cryptography, it attracts much attention.
 
 An efficient solution for an NP problem would break most existing cryptosystems, which is not a good result
 
 But there are also positive consequences, influencing important fields, such as logistics management and protein structure prediction.
 
 ---

 *A problem may demand decades, even centuries to be solved. It is up to people, aided by machines, to prepare themselves to find the solution for the existing problems, which can transform the future of the humankind.*
 */

//#-hidden-code

import PlaygroundSupport
import SpriteKit
import UIKit
import BookCore

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 1366, height: 1024))
if let scene = IntroScene(fileNamed: "IntroScene") {
    scene.scaleMode = .aspectFit
    sceneView.presentScene(scene)
}

PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true

//#-end-hidden-code
