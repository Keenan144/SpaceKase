//
//  File.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/21/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import Foundation
import SpriteKit

class Health: SKSpriteNode {
    class func spawn() -> SKSpriteNode {
        let healthColor = UIColor.greenColor()
        let healthSize = CGSize(width: 20, height: 20)
        let health = SKSpriteNode(color: healthColor, size: healthSize)
        
        health.physicsBody = SKPhysicsBody(rectangleOfSize: healthSize)
        health.physicsBody?.dynamic = true
        health.physicsBody?.usesPreciseCollisionDetection = true
        health.physicsBody?.affectedByGravity = false
        health.physicsBody?.velocity.dy = -300
        
        health.name = "Health"
        
        return health
    }
    
    class func showHealth(label: SKLabelNode) -> SKLabelNode {
        label.removeFromParent()
        label.text = "Health: \(SpaceShip.shipHealth())"
        switch (SpaceShip.shipHealth()) {
        case _ where (SpaceShip.shipHealth() > 80):
            label.fontColor = UIColor.greenColor()
        case _ where (SpaceShip.shipHealth() > 60):
            label.fontColor = UIColor.yellowColor()
        case _ where (SpaceShip.shipHealth() > 40):
            label.fontColor = UIColor.orangeColor()
        case _ where (SpaceShip.shipHealth() > 20):
            label.fontColor = UIColor.redColor()
        default:
            label.fontColor = UIColor.grayColor()
        }
        
        return label
    }
}
