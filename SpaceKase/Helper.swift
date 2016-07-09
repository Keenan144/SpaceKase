//
//  Helper.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/23/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class Helper: SKNode {
    static var invincible = Bool()
    static var defaults = NSUserDefaults.standardUserDefaults()
    static var invincibilityTimer = Int32()
    static var invincibilityNSTimer = NSTimer()
    
    class func randomSpawn()  -> Int {
        if randomInRange(0.0, hi: 5.0) >= 4.5 {
            if invincible == false {
                return 1
            }
        }
        return 0
    }
    
    class func randomInRange(lo: CGFloat, hi : CGFloat) -> CGFloat {
        return lo + CGFloat(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    class func randomSpawnPoint(valueLowX: CGFloat, valueHighX: CGFloat, valueY: CGFloat) -> CGPoint {
        return CGPoint(x: randomInRange(valueLowX, hi: valueHighX), y: valueY + 100)
    }
    
    class func toggleInvincibility(value: Bool) {
        defaults.setObject(value, forKey: "Invincible")
    }
    
    class func toggleRun(value: Bool) {
        defaults.setObject(value, forKey: "Run")
    }
    
    class func setLastScore(score: Int) {
        defaults.setObject(score, forKey: "LastScore")
    }
    
    class func canRun() -> Bool {
        return defaults.objectForKey("Run") as! Bool
    }
    
    class func setShipHealth() -> Int {
        return defaults.objectForKey("Health") as! Int
    }
    
    class func isInvincible() -> Bool {
        return defaults.objectForKey("Invincible") as! Bool
    }
    
    class func deductHealth() -> Int {
        return defaults.objectForKey("Damage") as! Int
    }
    
    class func rockSpawnRate() -> NSTimeInterval {
        return defaults.objectForKey("SpawnRate") as! NSTimeInterval
    }
    
    class func setRockSpawnRate(score: NSInteger) {
        var spawnRate = NSTimeInterval()
        switch (score) {
            case _ where (score == 1500):
            spawnRate = 0.2
            case _ where (score == 1000):
            spawnRate = 0.3
            case _ where (score == 500):
            spawnRate = 0.4
            case _ where (score == 250):
            spawnRate = 0.5
            default:
            spawnRate = 1.0
        }
        defaults.setObject(spawnRate, forKey: "SpawnRate")
    }
}
