//
//  Rock.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/4/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import Foundation
import SpriteKit

class Rock: SKSpriteNode {
    
    class func spawn() -> SKSpriteNode {
        let rockColor = UIColor.blueColor()
        let rockSize = CGSize(width: 20, height: 20)
        let rock = SKSpriteNode(color: rockColor, size: rockSize)
        
        rock.physicsBody = SKPhysicsBody(rectangleOfSize: rockSize)
        rock.physicsBody?.dynamic = true
        rock.physicsBody?.usesPreciseCollisionDetection = true
        rock.physicsBody?.affectedByGravity = true
        

        
        rock.name = "Rock"
    
        return rock
    }
}
