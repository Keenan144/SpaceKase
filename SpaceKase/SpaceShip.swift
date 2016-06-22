//
//  SpaceShip.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/4/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class SpaceShip: SKScene {
    
    static var health = Int()
    
    class func spawn(shipCategory: UInt32, rockCategory: UInt32, frame: CGRect) -> SKSpriteNode {
        let shipSize = CGSize(width: 60, height: 60)
        let ship = SKSpriteNode(color: UIColor.grayColor(), size: shipSize)
        
        ship.texture = SKTexture(imageNamed: "Spaceship")
        
        ship.physicsBody = SKPhysicsBody(texture: ship.texture!, alphaThreshold: 0, size: shipSize)

        ship.physicsBody?.dynamic = false
        ship.physicsBody?.collisionBitMask = 1;
        ship.physicsBody?.usesPreciseCollisionDetection = true
        
        ship.physicsBody?.categoryBitMask = shipCategory
        ship.physicsBody?.contactTestBitMask = rockCategory
        
        ship.position = CGPoint(x: frame.midX, y: frame.midY - 150)
        
        ship.name = "Ship"
 
        return ship
    }
    
    class func deductHealth(damage: Int) {
        health = health - damage
        print("Ship health --> {\(health)}")
    }
    
    class func shipHealth() -> Int {
        return health
    }
    
    class func dead() -> Bool {
        return checkHealth(health)
    }
    
    static func checkHealth(health: Int) -> Bool {
        if health > 1 {
            return false
        }
        return true
    }
    
    static func setShipHealth(newHealth: Int) {
        health = newHealth
    }
}
