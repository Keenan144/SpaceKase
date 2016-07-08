//
//  Booster.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/22/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class Boost: SKSpriteNode {
    static var canSpawn:Bool!
    static var timer:NSTimer!
    
    class func spawnInvincibility() -> SKSpriteNode {
        if canSpawn == nil || canSpawn == true {
            let boostColor = UIColor.yellowColor()
            let boostSize = CGSize(width: 20, height: 20)
            let boost = SKSpriteNode(color: boostColor, size: boostSize)
            
            boost.texture = SKTexture(imageNamed: "Shield")
            
            boost.physicsBody = SKPhysicsBody(rectangleOfSize: boostSize)
            boost.physicsBody?.dynamic = true
            boost.physicsBody?.usesPreciseCollisionDetection = true
            boost.physicsBody?.affectedByGravity = false
            boost.physicsBody?.velocity.dy = -250
            
            boost.name = "Invincibility"

            canSpawn = false
             print("BOOST: spawnInvincibility")
            return boost
        }
        print("BOOST: spawnScoreBump()")
        return Boost.spawnScoreBump()
    }
    
    class func spawnScoreBump() -> SKSpriteNode {
        let boostColor = UIColor.cyanColor()
        let boostSize = CGSize(width: 20, height: 20)
        let boost = SKSpriteNode(color: boostColor, size: boostSize)
        
        boost.texture = SKTexture(imageNamed: "Point")
        
        boost.physicsBody = SKPhysicsBody(rectangleOfSize: boostSize)
        boost.physicsBody?.dynamic = true
        boost.physicsBody?.usesPreciseCollisionDetection = true
        boost.physicsBody?.affectedByGravity = false
        boost.physicsBody?.velocity.dy = -250
        
        boost.name = "ScoreBump"
        
        print("BOOST: spawnScoreBump")
        return boost
    }
}