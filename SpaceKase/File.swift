//
//  File.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/21/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//


import SpriteKit

class Health: SKSpriteNode {
    class func spawn() -> SKSpriteNode {
        let boostColor = UIColor.greenColor()
        let boostSize = CGSize(width: 20, height: 20)
        
        let boost = PhysicsHelper.setNodePhysics(boostSize, boostColor: boostColor, name: "Health", velocity: -250)
        boost.texture = SKTexture(imageNamed: "Health")
        
        print("HEALTH: spawn")
        return boost
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
        
        print("HEALTH: showHealth")
        return label
    }
}
