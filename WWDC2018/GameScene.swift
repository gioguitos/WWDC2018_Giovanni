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
    var boss1: SKSpriteNode!
    var floor: SKSpriteNode!
    var wall: SKSpriteNode!
    
    var bossHp = 100
    
    var inAir:Bool = false
    var currentButton:Bool = false
    var currentButton2:Bool = false
    
    
    var textureAtlasRight = SKTextureAtlas()
    var textureArrayRight = [SKTexture]()
    var textureAtlasLeft = SKTextureAtlas()
    var textureArrayLeft = [SKTexture]()
    var textureAtlasJumpRight = SKTextureAtlas()
    var textureArrayJumpRight = [SKTexture]()
    var textureAtlasJumpLeft = SKTextureAtlas()
    var textureArrayJumpLeft = [SKTexture]()
    
    var cavern = [SKSpriteNode]()
    
    
    
    
    private var activeTouches = [UITouch:String]()
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
        
        thief.physicsBody?.allowsRotation = false
        
        thief.physicsBody?.restitution = 0
        
        


    }

    func setupBoss1(){

        boss1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: boss1.size.width, height: boss1.size.height))

        boss1.physicsBody?.usesPreciseCollisionDetection = true

        boss1.physicsBody?.categoryBitMask = bossCategory

        boss1.physicsBody?.contactTestBitMask = thiefCategory
        
        boss1.physicsBody?.isDynamic = false




    }
    func setupFloor(obj: SKSpriteNode){

//        floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: floor.size.width, height: floor.size.height))
//
//        floor.physicsBody?.usesPreciseCollisionDetection = true
//
//        floor.physicsBody?.categoryBitMask = floorCategory
//
//        floor.physicsBody?.contactTestBitMask = thiefCategory
//
//        floor.physicsBody?.isDynamic = false
//
//        floor.physicsBody?.allowsRotation = false
//
//        floor.physicsBody?.restitution = 0
        obj.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: obj.size.width, height: obj.size.height))
        
        obj.physicsBody?.usesPreciseCollisionDetection = true
        
        obj.physicsBody?.categoryBitMask = floorCategory
        
        obj.physicsBody?.contactTestBitMask = thiefCategory
        
        obj.physicsBody?.isDynamic = false
        
        obj.physicsBody?.allowsRotation = false
        
        obj.physicsBody?.restitution = 0
    }
    
    func setupWall(){

        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: wall.size.width, height: wall.size.height))

        wall.physicsBody?.usesPreciseCollisionDetection = true

        wall.physicsBody?.categoryBitMask = floorCategory

        wall.physicsBody?.contactTestBitMask = thiefCategory

        wall.physicsBody?.isDynamic = false
        
        wall.physicsBody?.restitution = 0
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstNode = contact.bodyA.node as! SKSpriteNode
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        
        if firstNode.name == "thief" && secondNode.name == "boss"{
            
            bossHp -= 50
            
            physicsWorld.gravity = CGVector(dx:0, dy:-5)
            
            if bossHp <= 0{
                boss1.removeFromParent()
            }
        }
        
        for i in 1...5{
            if secondNode.name == "thief" && firstNode.name == cavern[i].name{
                print(cavern[i])
                inAir = false
            
            
            
                thief.removeAction(forKey: "jumpRight")
                thief.removeAction(forKey: "jumpLeft")
                if currentButton == false{
                    thief.removeAction(forKey: "animationRight")
                    thief.texture = SKTexture(imageNamed: textureAtlasRight.textureNames[0])
                
                }
                else{
                    thief.action(forKey: "animationRight")
                }
            
                if currentButton2 == false{
                    thief.removeAction(forKey: "animationLeft")
                    thief.texture = SKTexture(imageNamed: textureAtlasLeft.textureNames[0])
                
                }
                else{
                    thief.action(forKey: "animationLeft")
                }
            
            
            }
            
        }
        
        if secondNode.name == "floor" && firstNode.name == "thief"{
            
            inAir = false
            
            
            
            thief.removeAction(forKey: "jumpRight")
            thief.removeAction(forKey: "jumpLeft")
            if currentButton == false{
                thief.removeAction(forKey: "animationRight")
                thief.texture = SKTexture(imageNamed: textureAtlasRight.textureNames[0])

            }
            else{
                thief.action(forKey: "animationRight")
            }
            
            if currentButton2 == false{
                thief.removeAction(forKey: "animationLeft")
                thief.texture = SKTexture(imageNamed: textureAtlasLeft.textureNames[0])
                
            }
            else{
                thief.action(forKey: "animationLeft")
            }
            
            
        }
        
        if secondNode.name == "wall" && firstNode.name == "thief"{
            
            
            inAir = false
            
            thief.texture = SKTexture(imageNamed: textureAtlasRight.textureNames[0])
            
            thief.removeAction(forKey: "jumpRight")
            
            
            
        }
       
        
            
    }
        
    
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        textureAtlasRight = SKTextureAtlas(named: "right")
        
        for frames in 0...textureAtlasRight.textureNames.count - 1{
            
            let nameRight = "moving\(frames).png"
            
            textureArrayRight.append(SKTexture(imageNamed: nameRight))
        }
        
        
        
        textureAtlasLeft = SKTextureAtlas(named: "left")
        
        for frames in 0...textureAtlasLeft.textureNames.count - 1{
            
            let nameLeft = "moving\(frames)left.png"
            
            textureArrayLeft.append(SKTexture(imageNamed: nameLeft))
        }
        
        
        
        textureAtlasJumpRight = SKTextureAtlas(named: "jumpRight")
        let nameJumpRight = "thiefJump.png"
        textureArrayJumpRight.append(SKTexture(imageNamed: nameJumpRight))
        
        
        
        
        
        textureAtlasJumpLeft = SKTextureAtlas(named: "jumpLeft")
        
        for frames in 0...textureAtlasJumpLeft.textureNames.count {
           
            let nameJumpLeft = "jump\(frames)left.png"
            
            textureArrayJumpLeft.append(SKTexture(imageNamed: nameJumpLeft))
        }
        
        
        thief = childNode(withName: "thief") as? SKSpriteNode
       
        boss1 = childNode(withName: "boss") as? SKSpriteNode
        
        floor = childNode(withName: "floor") as? SKSpriteNode
        
        wall = childNode(withName: "wall") as? SKSpriteNode
        
        cameraMan = childNode(withName: "cameraMan") as? SKCameraNode
        
        for i in 1...6{
            
            cavern.append((childNode(withName: "rockmountain\(i)") as? SKSpriteNode)!)
            
        }
        for i in 1...5{
            print(cavern[i])
            setupFloor(obj: cavern[i])
        }
        
        physicsWorld.gravity = CGVector(dx:0, dy:-5)
        
        physicsWorld.contactDelegate = self
        
        floor.physicsBody?.affectedByGravity = false
        
        setupThief()
        setupBoss1()
        setupFloor(obj: floor)
        setupWall()
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for touch in touches {
            let button = findButtonName(from:touch)
            activeTouches[touch] = button
            tapBegin(on: button)
        }
    
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
            
        let moveRight = SKAction.moveBy(x: 30, y: 0, duration: 0.2)
        
        let moveRightForEver = SKAction.repeatForever(moveRight)
        
        let animation = SKAction.animate(with: textureArrayRight, timePerFrame: 0.1)
        
        let animationForEver = SKAction.repeatForever(animation)
        
        currentButton = true
        
        thief.run(moveRightForEver, withKey: "right")
            
            if inAir == false{
                
                   thief.run(animationForEver, withKey: "animationRight")
                
                
            }
            
        }
        if button == "left"{
            
            let moveLeft = SKAction.moveBy(x: -30, y: 0, duration: 0.1)
            
            let animation = SKAction.animate(with: textureArrayLeft, timePerFrame: 0.1)
            
            let animationForEver = SKAction.repeatForever(animation)
            
            let moveLeftForEver = SKAction.repeatForever(moveLeft)
            
            currentButton2 = true
            
            thief.run(moveLeftForEver, withKey: "left")
            
            if inAir == false{
                    
                thief.run(animationForEver, withKey: "animationLeft")

                
            }
            
            
            
          
        }
        print(currentButton)
        print(currentButton2)
        
        if currentButton == true && currentButton2 == true{
            thief.removeAction(forKey: "animationLeft")
            thief.removeAction(forKey: "animationRight")
            thief.texture = SKTexture(imageNamed: textureAtlasRight.textureNames[0])
            
        }
        
        
        
        
        if button == "jump"{
            if inAir == false {
            
                let jumpUpAction = SKAction.moveBy(x:0, y:150, duration:0.2)
                
                let animation = SKAction.animate(with: textureArrayJumpRight, timePerFrame: 0.1)
                
                let animationForEver = SKAction.repeatForever(animation)
                
                let jumpDownAction = SKAction.moveBy(x:0, y:0, duration: 0.2)
                
                let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
                
                
                thief.run(jumpSequence, withKey: "jump")
                
                thief.run(animationForEver, withKey: "jumpRight")
                
                inAir = true
                
                
                
            }
            
            
 
        }
        
    }
    
    private func tapEnd(on button:String) {
        if button == "right"{
            thief.removeAction(forKey: "right")
         
            if inAir == false{
                thief.texture = SKTexture(imageNamed: textureAtlasRight.textureNames[0])
                thief.removeAction(forKey: "animationRight")
              
                
            }
            currentButton = false
        }
        if button == "left"{
            thief.removeAction(forKey: "left")
          
            
            if inAir == false{
                thief.texture = SKTexture(imageNamed: textureAtlasLeft.textureNames[0])
                thief.removeAction(forKey: "animationLeft")
                
                
            }
            currentButton2 = false
        }
        
        if button == "right" || button == "left"{
            if currentButton == true && currentButton2 == false{
                
                let animation = SKAction.animate(with: textureArrayRight, timePerFrame: 0.1)
                
                let animationForEver = SKAction.repeatForever(animation)
                
                thief.run(animationForEver, withKey: "animationRight")

            
            }
        
            if currentButton == false && currentButton2 == true{
            

            
                let animation = SKAction.animate(with: textureArrayLeft, timePerFrame: 0.1)
            
                let animationForEver = SKAction.repeatForever(animation)
            
                thief.run(animationForEver, withKey: "animationLeft")
            
            
            }
        }
        
        if button == "jump"{
            
        }

        print("End",currentButton)
        print("End",currentButton2)
        
        
        
        
        
    }
    
    
    
    private func findButtonName(from touch: UITouch) -> String {

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

