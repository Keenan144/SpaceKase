//
//  MenuScene.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/3/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var button:SKLabelNode!
    var touchLocation:CGPoint!
    
    override func didMoveToView(view: SKView) {
        addButtons()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            let pos = touch.locationInNode(self)
            let node = self.nodeAtPoint(pos)
            
            if node == button {
                startGame()
            } else {
                print("Error [startGame => FAILED TOUCH]")
                print("ERROR [\(button.position) => \(touchLocation)]")
            }
        }
    }
    
    
    private func addButtons() {
        button = SKLabelNode(fontNamed: "Arial")
        button.text = "Start Game"
        button.fontSize = 20
        button.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        self.addChild(button)
    }
    
    private func startGame() {
        let skView = self.view as! SKView!;
        let gameScene = GameScene(size: skView.bounds.size)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }
}
