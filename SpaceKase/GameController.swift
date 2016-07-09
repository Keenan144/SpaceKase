//
//  GameController.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 7/9/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class GameController: SKNode {
    class func setRockSpawnRate(score: NSInteger) {
        var spawnRate = NSTimeInterval()
        switch (score) {
        case _ where (score == 1500):
            spawnRate = 0.2
        case _ where (score == 1000):
            spawnRate = 0.3
        case _ where (score == 500):
            spawnRate = 0.4
        case _ where (score == 250):
            spawnRate = 0.5
        default:
            spawnRate = 1.0
        }
        NSUserDefaults().setObject(spawnRate, forKey: "SpawnRate")
    }
}