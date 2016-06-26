//
//  PowerUpController.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/22/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class PowerUp: SKSpriteNode {
    class func randomInRange(lo: CGFloat, hi : CGFloat) -> CGFloat {
         print("POWERUPCONTROLLER: randomInRange")
        return lo + CGFloat(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    class func spawnHealth() -> SKSpriteNode {
        print("POWERUPCONTROLLER: spawnHealth")
        return Health.spawn()
    }
    
    class func spawnInvincibility() -> SKSpriteNode {
        print("POWERUPCONTROLLER: spawnInvincibility")
        return Boost.spawnInvincibility()
    }
}
