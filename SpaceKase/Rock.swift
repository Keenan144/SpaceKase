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
        let rockSize = CGSize(width: 30, height: 40)
        let rock = SKSpriteNode(color: rockColor, size: rockSize)
        
        rock.texture = SKTexture(imageNamed: "Rock")
        rock.physicsBody = SKPhysicsBody(texture: rock.texture!, alphaThreshold: 0, size: rockSize)
        rock.physicsBody?.dynamic = true
        rock.physicsBody?.usesPreciseCollisionDetection = true
        rock.physicsBody?.affectedByGravity = true
        rock.name = "Rock"
        
        print("ROCK: spawn")
        return rock
    }
}
