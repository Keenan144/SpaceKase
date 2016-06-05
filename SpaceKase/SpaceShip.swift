//
//  SpaceShip.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/4/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class SpaceShip: SKScene {
    
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
        
        ship.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame) - 150)
 
        return ship
    }
}
