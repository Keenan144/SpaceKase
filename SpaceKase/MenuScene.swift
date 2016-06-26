//
//  MenuScene.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/3/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    @IBOutlet weak var instruction: SKLabelNode?
    
    var startButton:SKLabelNode!
    var settingsButton:SKLabelNode!
    var touchLocation:CGPoint!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func didMoveToView(view: SKView) {
        setHighScores()
        setDefaults()
        addStartButton()
        addSettingsButton()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent: UIEvent?) {
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
    
    private func setHighScores() {
        if (defaults.objectForKey("p1") == nil) {
            defaults.setObject(0, forKey: "p1")
            defaults.setObject(0, forKey: "p2")
            defaults.setObject(0, forKey: "p3")
            defaults.setObject(0, forKey: "p4")
            defaults.setObject(0, forKey: "p5")
        }
    }
    
    private func setDefaults() {
        if (defaults.objectForKey("Health") == nil) {
            defaults.setObject(100, forKey: "Health")
            defaults.setObject(5, forKey: "Damage")
            defaults.setObject(1, forKey: "SpawnRate")
            defaults.setObject(false, forKey: "Run")
        }
        
        if defaults.objectForKey("Invincible") == nil {
            Helper.toggleInvincibility(false)
        }
    }
    
    
    private func addStartButton() {
        startButton = SKLabelNode(fontNamed: "Arial")
        startButton.text = "Start Game"
        startButton.fontSize = 20
        startButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(startButton)
    }
    
    private func addSettingsButton() {
        settingsButton = SKLabelNode(fontNamed: "Arial")
        settingsButton.text = "Settings"
        settingsButton.fontSize = 20
        settingsButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 50)
        
        self.addChild(settingsButton)
    }
    
    private func startGame() {
        let skView = self.view as SKView!;
        let gameScene = GameScene(size: (skView?.bounds.size)!)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }
    
    private func startSettings() {
        let skView = self.view as SKView!;
        let gameScene = SettingScene(size: (skView?.bounds.size)!)
        let transition = SKTransition.fadeWithDuration(0.15)
        view!.presentScene(gameScene, transition: transition)
    }
}
