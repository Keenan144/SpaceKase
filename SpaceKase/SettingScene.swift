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
    var resetButton:SKLabelNode!
    var godModeButton:SKLabelNode!
    var touchLocation:CGPoint!
    
    override func didMoveToView(view: SKView) {
        addBackButton()
        addEasyButton()
        addNormalButton()
        addHardButton()
//        addGodModeButton()
        addResetButton()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            let pos = touch.locationInNode(self)
            let node = nodeAtPoint(pos)
            
            print(backButton)
            if (node == backButton) {
                startMenu()
            } else if (node == easyButton) {
                defaults.setObject(200, forKey: "Health")
                defaults.setObject(5, forKey: "Damage")
                defaults.setObject(1, forKey: "SpawnRate")
                startMenu()
            } else if  (node == normalButton) {
                defaults.setObject(150, forKey: "Health")
                defaults.setObject(10, forKey: "Damage")
                defaults.setObject(0.5, forKey: "SpawnRate")
                startMenu()
            } else if (node == hardButton) {
                defaults.setObject(100, forKey: "Health")
                defaults.setObject(20, forKey: "Damage")
                defaults.setObject(0.2, forKey: "SpawnRate")
                startMenu()
            } else if (node == resetButton) {
                defaults.setObject(150, forKey: "Health")
                defaults.setObject(10, forKey: "Damage")
                defaults.setObject(0.5, forKey: "SpawnRate")
                defaults.setObject(0, forKey: "p1")
                defaults.setObject(0, forKey: "p2")
                defaults.setObject(0, forKey: "p3")
                defaults.setObject(0, forKey: "p4")
                defaults.setObject(0, forKey: "p5")
                startMenu()
            } else if (node == godModeButton) {
//                if defaults.objectForKey("GodMode") == nil || defaults.objectForKey("GodMode") as! Bool == false {
//                    defaults.setObject(false, forKey: "GodMode")
//                } else {
//                    defaults.setObject(true, forKey: "GodMode")
//                }
//                startMenu()
            } else {
                print("UNKNOWN ACTION")
                print("ERROR [\(touchLocation)]")
            }
            
        }
    }
    
    private func setDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(100, forKey: "Health")
        defaults.setObject(5, forKey: "Damage")
    }
    
    
    private func addBackButton() {
        backButton = SKLabelNode(fontNamed: "Arial")
        backButton.text = "Back"
        backButton.fontSize = 20
        backButton.position = CGPoint(x: self.frame.minX + 30 , y: self.frame.maxY - 30)
        
        self.addChild(backButton)
    }
    
    private func addEasyButton() {
        easyButton = SKLabelNode(fontNamed: "Arial")
        easyButton.text = "Easy"
        easyButton.fontSize = 20
        easyButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 50)
        
        self.addChild(easyButton)
    }
    
    private func addNormalButton() {
        normalButton = SKLabelNode(fontNamed: "Arial")
        normalButton.text = "Normal"
        normalButton.fontSize = 20
        normalButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(normalButton)
    }
    
    private func addHardButton() {
        hardButton = SKLabelNode(fontNamed: "Arial")
        hardButton.text = "Hard"
        hardButton.fontSize = 20
        hardButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 50 )
        
        self.addChild(hardButton)
    }
    
    private func addGodModeButton() {
        godModeButton = SKLabelNode(fontNamed: "Arial")
        godModeButton.text = "God Mode: \(defaults.objectForKey("GodMode")!)"
        godModeButton.fontSize = 20
        godModeButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 90 )
        
        self.addChild(godModeButton)
    }
    
    private func addResetButton() {
        resetButton = SKLabelNode(fontNamed: "Arial")
        resetButton.text = "Reset"
        resetButton.fontSize = 10
        resetButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 220)
        
        self.addChild(resetButton)
    }
    
    private func startMenu() {
        let skView = self.view as SKView!;
        let gameScene = MenuScene(size: (skView?.bounds.size)!)
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
