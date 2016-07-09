//
//  Physics.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 7/9/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit


class PhysicsHelper: SKNode {
    class func setNodePhysics(boostSize: CGSize, boostColor: UIColor, name: String, velocity: CGFloat ) -> SKSpriteNode {
        let boost = SKSpriteNode(color: boostColor, size: boostSize)
        boost.texture = SKTexture(imageNamed: "Point")
        boost.physicsBody = SKPhysicsBody(rectangleOfSize: boostSize)
        boost.physicsBody?.dynamic = true
        boost.physicsBody?.usesPreciseCollisionDetection = true
        boost.physicsBody?.affectedByGravity = false
        boost.physicsBody?.velocity.dy = velocity
        boost.name = name
        
        return boost
    }
}