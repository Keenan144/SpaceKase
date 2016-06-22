//
//  boundary.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/5/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import Foundation
import SpriteKit

class Boundary: SKScene, SKPhysicsContactDelegate {
    
    class func setBottomBoundary(boundaryCategory: UInt32, rockCategory: UInt32, frame: CGRect) -> SKSpriteNode {
        var boundary = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: frame.width, height: 1))
        boundary.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: frame.width, height: 1))
        boundary.position = CGPoint(x: frame.midX, y: frame.minY)
        boundary = setBoundary(boundary, boundaryCategory: boundaryCategory, rockCategory: rockCategory)
        return boundary
    }
    
    class func setRightSideBoundary(boundaryCategory: UInt32, rockCategory: UInt32, frame: CGRect) -> SKSpriteNode {
        var boundary = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 1, height: frame.height))
        boundary.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: frame.height))
        boundary.position = CGPoint(x: frame.maxX, y: frame.midY)
        boundary = setBoundary(boundary, boundaryCategory: boundaryCategory, rockCategory: rockCategory)
        return boundary
    }
    
    class func setLeftSideBoundary(boundaryCategory: UInt32, rockCategory: UInt32, frame: CGRect) -> SKSpriteNode {
        var boundary = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 1, height: frame.height))
        boundary.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: frame.height))
        boundary.position = CGPoint(x: frame.minX, y: frame.midY)
        boundary = setBoundary(boundary, boundaryCategory: boundaryCategory, rockCategory: rockCategory)
        return boundary
    }
    
    class func setBoundary(boundary: SKSpriteNode, boundaryCategory: UInt32, rockCategory: UInt32) -> SKSpriteNode {
        boundary.physicsBody?.dynamic = false
        boundary.physicsBody?.categoryBitMask = boundaryCategory
        boundary.physicsBody?.contactTestBitMask = rockCategory
        boundary.physicsBody?.collisionBitMask = 0;
        boundary.physicsBody?.usesPreciseCollisionDetection = true
        return boundary
    }
}
