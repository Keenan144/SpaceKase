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
        var boundary = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: CGRectGetWidth(frame), height: 1))
        boundary.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: CGRectGetWidth(frame), height: 1))
        boundary.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMinY(frame))
        boundary = setBoundary(boundary, boundaryCategory: boundaryCategory, rockCategory: rockCategory)
        return boundary
    }
    
    class func setRightSideBoundary(boundaryCategory: UInt32, rockCategory: UInt32, frame: CGRect) -> SKSpriteNode {
        var boundary = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 1, height: CGRectGetHeight(frame)))
        boundary.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: CGRectGetHeight(frame)))
        boundary.position = CGPoint(x: CGRectGetMaxX(frame), y: CGRectGetMidY(frame))
        boundary = setBoundary(boundary, boundaryCategory: boundaryCategory, rockCategory: rockCategory)
        return boundary
    }
    
    class func setLeftSideBoundary(boundaryCategory: UInt32, rockCategory: UInt32, frame: CGRect) -> SKSpriteNode {
        var boundary = SKSpriteNode(color: UIColor.blackColor(), size: CGSize(width: 1, height: CGRectGetHeight(frame)))
        boundary.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: CGRectGetHeight(frame)))
        boundary.position = CGPoint(x: CGRectGetMinX(frame), y: CGRectGetMidY(frame))
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
