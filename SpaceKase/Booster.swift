//
//  Booster.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/22/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class Boost: SKSpriteNode {
    static var invincibilityTimer:Int! = 1
    static var showInvincibleLabel:SKLabelNode!
    static var canSpawn:Bool!
    static var timer:NSTimer!
    
    class func spawnInvincibility() -> SKSpriteNode {
        if canSpawn == nil || canSpawn == true {
            let boostColor = UIColor.yellowColor()
            let boostSize = CGSize(width: 20, height: 20)
            let boost = SKSpriteNode(color: boostColor, size: boostSize)
            
            boost.physicsBody = SKPhysicsBody(rectangleOfSize: boostSize)
            boost.physicsBody?.dynamic = true
            boost.physicsBody?.usesPreciseCollisionDetection = true
            boost.physicsBody?.affectedByGravity = false
            boost.physicsBody?.velocity.dy = -250
            
            boost.name = "Invincibility"

            canSpawn = false
            spawnerTimeout()
            return boost
        }
        return Boost.spawnScoreBump()
    }
    
    class func spawnScoreBump() -> SKSpriteNode {
        let boostColor = UIColor.cyanColor()
        let boostSize = CGSize(width: 20, height: 20)
        let boost = SKSpriteNode(color: boostColor, size: boostSize)
        
        boost.physicsBody = SKPhysicsBody(rectangleOfSize: boostSize)
        boost.physicsBody?.dynamic = true
        boost.physicsBody?.usesPreciseCollisionDetection = true
        boost.physicsBody?.affectedByGravity = false
        boost.physicsBody?.velocity.dy = -250
        
        boost.name = "ScoreBump"
        
        return boost
    }
    
    class func spawnerTimer() {
        if Helper.canRun() {
            print("invincibiliy timer: \(invincibilityTimer)")
            invincibilityTimer = invincibilityTimer + 1
            if invincibilityTimer >= 30 {
                invincibilityTimer = 1
                timer.invalidate()
                canSpawn = true
            }
        }
    }
    
    class func spawnerTimeout() {
        if Helper.canRun() {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("spawnerTimer"), userInfo: nil, repeats: true)
        }
    }
}