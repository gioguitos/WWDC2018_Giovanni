//
//  GameScene.swift
//  WWDC2018
//
//  Created by Giovanni Severo Barros on 21/03/18.
//  Copyright © 2018 Giovanni Severo Barros. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var thief: SKSpriteNode!
    var arrow: SKSpriteNode!
    var boss1: SKSpriteNode!
    var floor: SKSpriteNode!
    var bossHp = 100
    var inAir:Bool = false
    
    
    private var activeTouches = [UITouch:String]()

    
    private var bossHitbox: SKSpriteNode!
    private var attackHitbox: SKSpriteNode!
    
    private var cameraMan: SKCameraNode?
    
    
    
    let thiefCategory: UInt32 = 0x1 << 0
    let floorCategory: UInt32 = 0x1 << 1
    let bossCategory:  UInt32 = 0x1 << 2
    
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    func setupThief(){

        thief.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: thief.size.width, height: thief.size.height))

        thief.physicsBody?.usesPreciseCollisionDetection = true

        thief.physicsBody?.categoryBitMask = thiefCategory

        thief.physicsBody?.contactTestBitMask = bossCategory
        
        


    }

    func setupBoss1(){

        boss1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: boss1.size.width, height: boss1.size.height))

        boss1.physicsBody?.usesPreciseCollisionDetection = true

        boss1.physicsBody?.categoryBitMask = bossCategory

        boss1.physicsBody?.contactTestBitMask = thiefCategory
        
        boss1.physicsBody?.isDynamic = false




    }
    func setupFloor(){

        floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: floor.size.width, height: floor.size.height))

        floor.physicsBody?.usesPreciseCollisionDetection = true
        
        floor.physicsBody?.categoryBitMask = floorCategory
        
        boss1.physicsBody?.contactTestBitMask = thiefCategory

        floor.physicsBody?.isDynamic = false
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstNode = contact.bodyA.node as! SKSpriteNode
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        
        if firstNode.name == "thief" && secondNode.name == "boss"{
            print("Hit")
            
            bossHp -= 50
            print(bossHp)
            
            physicsWorld.gravity = CGVector(dx:0, dy:-5)
            
            if bossHp <= 0{
                boss1.removeFromParent()
            }
        }
        
        if secondNode.name == "floor" && firstNode.name == "thief"{
            
            print("Floor Hit")
            
        }
        
            
    }
        
    
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        thief = childNode(withName: "thief") as? SKSpriteNode

        arrow = childNode(withName: "arrow") as? SKSpriteNode
       
        boss1 = childNode(withName: "boss") as? SKSpriteNode
        
        floor = childNode(withName: "floor") as? SKSpriteNode
        
        attackHitbox = childNode(withName: "attackHitbox") as? SKSpriteNode

        bossHitbox = childNode(withName: "bossHitbox") as? SKSpriteNode
        
        
        

//        cameraMan = SKCameraNode()
//        self.camera = cameraMan
//        self.addChild(cameraMan!)


//        buttonsSetup(newThief: buttonsSetup)
//
        
        
        
        physicsWorld.gravity = CGVector(dx:0, dy:-5)
        physicsWorld.contactDelegate = self
        
        print(thief.position.y)
        
        floor.physicsBody?.affectedByGravity = false

        
        
        
        
        setupThief()
        setupBoss1()
        setupFloor()
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for touch in touches {
            let button = findButtonName(from:touch)
            activeTouches[touch] = button
            tapBegin(on: button)
        }
        let bodies = thief.physicsBody?.allContactedBodies()
        if (bodies?.isEmpty)!{
            inAir = true
        }
        else{
            inAir = false
        }
        

//        let touch = touches.first
//        let position = touch?.location(in: self)
//        let touchNode = self.atPoint(position!)
//
//        if let name = touchNode.name{
//            if name == "right"{
//
//                let moveRight = SKAction.moveBy(x: 10, y: 0, duration: 0.1)
//                let moveRightForEver = SKAction.repeatForever(moveRight)
//                thief.run(moveRightForEver, withKey: "right")
//                clickRight = true
////                thief.removeAction(forKey:"left")
//            }
//            if name == "left"{
//                let moveLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.1)
//                let moveLeftForEver = SKAction.repeatForever(moveLeft)
//                thief.run(moveLeftForEver, withKey: "left")
//                clickLeft = true
////                thief.removeAction(forKey:"right")
//
//
//            }
//            if name == "jump"{
//                let jumpUpAction = SKAction.moveBy(x:0, y:100, duration:0.2)
//                let jumpDownAction = SKAction.moveBy(x:0, y:-100, duration: 0.2)
//                let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
//                thief.run(jumpSequence, withKey: "jump")
//                clickJump = true
//            }
//            if name == "attack"{
        
                
                
//                 HitBoxes
//                self.attackHitbox?.isHidden = false
//                self.bossHitbox?.isHidden = false
//
//                attackHitbox.size = CGSize(width: 35, height: 35)
//                bossHitbox.size = CGSize(width: 35, height: 35)
//
//                attackHitbox.position = CGPoint(x: thief.position.x + 60, y: thief.position.y + 20)
//                bossHitbox.position = CGPoint(x: boss1.position.x - 120, y: thief.position.y + 20)
//
//                delay(0.5){
//                    self.attackHitbox?.isHidden = true
//                    self.bossHitbox?.isHidden = true
//                }
                
                
                
                
//                Remove o Boss
//                boss1.removeFromParent()
//
//            }
//        }
    
    
    }

  

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches {
            guard let button = activeTouches[touch] else { fatalError("Touch just ended but not found into activeTouches")}
            activeTouches[touch] = nil
            tapEnd(on: button)
        }
        
        
}
    private func tapBegin(on button: String) {
        if button == "right"{
            
        let moveRight = SKAction.moveBy(x: 10, y: 0, duration: 0.1)
        let moveRightForEver = SKAction.repeatForever(moveRight)
        thief.run(moveRightForEver, withKey: "right")
     
        }
        if button == "left"{
            
            let moveRight = SKAction.moveBy(x: -10, y: 0, duration: 0.1)
            let moveRightForEver = SKAction.repeatForever(moveRight)
            thief.run(moveRightForEver, withKey: "left")
          
        }
        
        if button == "jump"{
            if inAir == false {
                let jumpUpAction = SKAction.moveBy(x:0, y:100, duration:0.2)
                let jumpDownAction = SKAction.moveBy(x:0, y:-100, duration: 0.2)
                let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
                thief.run(jumpSequence, withKey: "jump")
                print(thief.position.y)
            }
            else{
                print("ta no ar nao pode pular")
            }
            
 
        }
        print(button)
    }
    
    private func tapEnd(on button:String) {
        if button == "right"{
            thief.removeAction(forKey: "right")
        }
        if button == "left"{
            thief.removeAction(forKey: "left")
        }
        
    }
    
    
    
    private func findButtonName(from touch: UITouch) -> String {
        // replace this with your custom logic to detect a button location
        let location = touch.location(in: self.view)
        if location.x > (self.view?.frame.midX)! && location.y > (self.view?.frame.midY)!{
            return "right"
        }
        if location.x < (self.view?.frame.midX)! && location.y > (self.view?.frame.midY)! {
            return "left"
        }
        else{
            return "jump"
        }
    }
    

    
    override func update(_ currentTime: TimeInterval)
    {
//        Camera Seguindo o Player
        if let camera = cameraMan, let player = thief{
            camera.position = player.position
        }
        
        
    }

}

