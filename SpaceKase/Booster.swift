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
            let boost = PhysicsHelper.setNodePhysics(boostSize, boostColor: boostColor, name: "Invincibility", velocity: -250)
            boost.texture = SKTexture(imageNamed: "Shield")
            
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
        let boost = PhysicsHelper.setNodePhysics(boostSize, boostColor: boostColor, name: "ScoreBump", velocity: -250)
        return boost
    }
}