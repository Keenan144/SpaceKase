//
//  MenuScene.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/3/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var startButton:SKLabelNode!
    var settingsButton:SKLabelNode!
    var touchLocation:CGPoint!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func didMoveToView(view: SKView) {
        setDefaults()
        addStartButton()
        addSettingsButton()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            let pos = touch.locationInNode(self)
            let node = self.nodeAtPoint(pos)
            
            if node == startButton {
                startGame()
            } else if node == settingsButton {
                startSettings()
            } else {
                print("Error [startGame => FAILED TOUCH]")
                print("ERROR =>  [\(touchLocation)]")
            }
        }
    }
    
    private func setDefaults() {
        if (defaults.objectForKey("Health") == nil) {
            defaults.setInteger(100, forKey: "Health")
            defaults.setInteger(5, forKey: "Damage")
            defaults.setFloat(1, forKey: "SpawnRate")
        }
    }
    
    
    private func addStartButton() {
        startButton = SKLabelNode(fontNamed: "Arial")
        startButton.text = "Start Game"
        startButton.fontSize = 20
        startButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        self.addChild(startButton)
    }
    
    private func addSettingsButton() {
        settingsButton = SKLabelNode(fontNamed: "Arial")
        settingsButton.text = "Settings"
        settingsButton.fontSize = 20
        settingsButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 50)
        
        self.addChild(settingsButton)
    }
    
    private func startGame() {
        let skView = self.view as SKView!;
        let gameScene = GameScene(size: skView.bounds.size)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }
    
    private func startSettings() {
        let skView = self.view as SKView!;
        let gameScene = SettingScene(size: skView.bounds.size)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }
}
