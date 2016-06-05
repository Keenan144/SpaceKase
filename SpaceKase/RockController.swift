//
//  RockController.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 5/29/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import Foundation
import SpriteKit

class RockController: SKScene {
    
    var rock = SKSpriteNode?()
    var rockColor = UIColor.blueColor()
    var rockSize = CGSize(width: 20, height: 20)

    
    func start() {
        rockTimer()
    }
    
    func rockTimer() {
         let timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("spawnRock"), userInfo: nil, repeats: true)
    }
    
    func spawnRock() {
        rock = SKSpriteNode(color: rockColor, size: rockSize)
        rock?.physicsBody = SKPhysicsBody(rectangleOfSize: rockSize)
        rock?.physicsBody?.dynamic = true
        rock?.position = CGPoint(x: randomInRange(CGRectGetMinX(frame), hi: CGRectGetMaxX(frame)), y: CGRectGetMaxY(self.frame) + 100)
        
        self.addChild(rock!)
    }
    
    func randomInRange(lo: CGFloat, hi : CGFloat) -> CGFloat {
    
        return lo + CGFloat(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
}

