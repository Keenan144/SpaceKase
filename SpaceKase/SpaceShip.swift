//
//  SpaceShip.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/4/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class SpaceShip {
    
    class func load() -> SKSpriteNode {
        return SKSpriteNode()
    }
    class func spawn(ship: SKSpriteNode, shipCategory: UInt32, rockCategory: UInt32) -> SKSpriteNode {
        let shipSize = CGSize(width: 60, height: 60)
        _ = UIColor.whiteColor()
        
        ship.physicsBody = SKPhysicsBody(rectangleOfSize: shipSize)
        ship.texture = SKTexture(imageNamed: "Spaceship")
        ship.physicsBody?.dynamic = false
        ship.physicsBody?.collisionBitMask = 1;
        ship.physicsBody?.usesPreciseCollisionDetection = true
        
        ship.physicsBody?.categoryBitMask = shipCategory
        ship.physicsBody?.contactTestBitMask = rockCategory
 
        return ship
    }
}
