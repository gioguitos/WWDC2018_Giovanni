//
//  buttonSetup.swift
//  WWDC2018
//
//  Created by Giovanni Severo Barros on 22/03/18.
//  Copyright © 2018 Giovanni Severo Barros. All rights reserved.
//

import SpriteKit
import GameplayKit

//class buttonsSetup: SKScene, SKPhysicsContactDelegate {
//    
//        var right: SKSpriteNode!
//        var left:  SKSpriteNode!
//        var attack: SKSpriteNode!
//    private var thief: SKSpriteNode!
//    
//    init(newThief:SKSpriteNode) {
//        self.thief = newThief
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func didMove(to view: SKView) {
//        
//        super.didMove(to: view)
//        
//        right = childNode(withName: "right") as? SKSpriteNode
//        
//        left = childNode(withName: "left") as? SKSpriteNode
//        
//        attack = childNode(withName: "attack") as? SKSpriteNode
//        
//        
//    }
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        
//        let touch = touches.first
//        let position = touch?.location(in: self)
//        let touchNode = self.atPoint(position!)
//        
//        if let name = touchNode.name{
//            if name == "right"{
//                let moveRight = SKAction.moveBy(x: 10, y: 0, duration: 0.1)
//                let moveRightForEver = SKAction.repeatForever(moveRight)
//                thief.run(moveRightForEver)
//            }
//            if name == "left"{
//                let moveLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.1)
//                let moveLeftForEver = SKAction.repeatForever(moveLeft)
//                thief.run(moveLeftForEver)
//                
//                
//            }
//            if name == "jump"{
//                let jumpUpAction = SKAction.moveBy(x:0, y:100, duration:0.2)
//                let jumpDownAction = SKAction.moveBy(x:0, y:100, duration: 0.2)
//                let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
//                thief.run(jumpSequence)
//            }
//            if name == "attack"{
//            
//                
//            }
//        }
//        
//        
//    }
//    
//}

