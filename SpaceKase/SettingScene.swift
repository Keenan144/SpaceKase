//
//  SettingScene.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/5/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class SettingScene: SKScene {
    
    var defaults = NSUserDefaults()
    
    var backButton:SKLabelNode!
    var easyButton:SKLabelNode!
    var normalButton:SKLabelNode!
    var hardButton:SKLabelNode!
    var touchLocation:CGPoint!
    
    override func didMoveToView(view: SKView) {
        addBackButton()
        addEasyButton()
        addNormalButton()
        addHardButton()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            let pos = touch.locationInNode(self)
            let node = self.nodeAtPoint(pos)
            
            print(backButton)
            if (node == backButton) {
                startMenu()
            } else if (node == easyButton) {
                defaults.setInteger(200, forKey: "Health")
                defaults.setInteger(5, forKey: "Damage")
                defaults.setFloat(1, forKey: "SpawnRate")
                startMenu()
            } else if  (node == normalButton) {
                defaults.setInteger(150, forKey: "Health")
                defaults.setInteger(10, forKey: "Damage")
                defaults.setFloat(0.5, forKey: "SpawnRate")
                startMenu()
            } else if (node == hardButton) {
                defaults.setInteger(100, forKey: "Health")
                defaults.setInteger(20, forKey: "Damage")
                defaults.setFloat(0.2, forKey: "SpawnRate")
                startMenu()
            } else {
                print("UNKNOWN ACTION")
                print("ERROR [\(touchLocation)]")
            }
            
        }
    }
    
    private func setDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(100, forKey: "Health")
        defaults.setInteger(5, forKey: "Damage")
    }
    
    
    private func addBackButton() {
        backButton = SKLabelNode(fontNamed: "Arial")
        backButton.text = "Back"
        backButton.fontSize = 20
        backButton.position = CGPointMake(CGRectGetMinX(self.frame) + 30 , CGRectGetMaxY(self.frame) - 30)
        
        self.addChild(backButton)
    }
    
    private func addEasyButton() {
        easyButton = SKLabelNode(fontNamed: "Arial")
        easyButton.text = "Easy"
        easyButton.fontSize = 20
        easyButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 50)
        
        self.addChild(easyButton)
    }
    
    private func addNormalButton() {
        normalButton = SKLabelNode(fontNamed: "Arial")
        normalButton.text = "Normal"
        normalButton.fontSize = 20
        normalButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        
        self.addChild(normalButton)
    }
    
    private func addHardButton() {
        hardButton = SKLabelNode(fontNamed: "Arial")
        hardButton.text = "Hard"
        hardButton.fontSize = 20
        hardButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 50 )
        
        self.addChild(hardButton)
    }
    
    private func startMenu() {
        let skView = self.view as SKView!;
        let gameScene = MenuScene(size: skView.bounds.size)
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
