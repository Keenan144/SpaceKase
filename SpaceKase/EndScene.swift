//
//  EndScene.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 6/21/16.
//  Copyright © 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit
import SystemConfiguration

class EndScene: SKScene {
    
    var startButton:SKLabelNode!
    var yourScore:SKLabelNode!
    var topScore:SKLabelNode!
    var secondScore:SKLabelNode!
    var thirdScore:SKLabelNode!
    var fourthScore:SKLabelNode!
    var fifthScore:SKLabelNode!
    var settingsButton:SKLabelNode!
    var touchLocation:CGPoint!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func didMoveToView(view: SKView) {
        showHighScores()
        setButtons()
        showScores()
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
    
    private func showHighScores() {
        if let yourScore = defaults.objectForKey("LastScore") as? NSInteger {
            if yourScore > defaults.objectForKey("p5") as! NSInteger && yourScore < defaults.objectForKey("p4") as! NSInteger {
                defaults.setObject(yourScore, forKey: "p5")
                return
            } else if yourScore > defaults.objectForKey("p4") as! NSInteger && yourScore < defaults.objectForKey("p3") as! NSInteger {
                defaults.setObject(yourScore, forKey: "p4")
                return
            } else if yourScore > defaults.objectForKey("p3") as! NSInteger && yourScore < defaults.objectForKey("p2") as! NSInteger {
                defaults.setObject(yourScore, forKey: "p3")
                return
            } else if yourScore > defaults.objectForKey("p2") as! NSInteger && yourScore < defaults.objectForKey("p1") as! NSInteger {
                defaults.setObject(yourScore, forKey: "p2")
                return
            } else if yourScore > defaults.objectForKey("p1") as! NSInteger {
                defaults.setObject(yourScore, forKey: "p1")
                if Reachability.isConnectedToNetwork() {
//                    UploadController.post(["uuid": "12345"], url: "http://boiling-ridge-62596.herokuapp.com/scan_code")
                }
                return
            } else {
                return
            }
        }
    }
    
    private func setButtons() {
        addStartButton()
        addSettingsButton()
    }
    
    private func showScores() {
        addLastScore()
        addTopScore()
//        addSecondScore()
//        addThirdScore()
//        addFourthScore()
//        addFifthScore()
    }
    
    private func addLastScore() {
        yourScore = SKLabelNode(fontNamed: "Arial")
        yourScore.text = "Your Score: \(defaults.objectForKey("LastScore")!)"
        yourScore.fontColor = UIColor.yellowColor()
        yourScore.fontSize = 40
        yourScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 220)
        
        self.addChild(yourScore)
    }
    
    private func addTopScore() {
        topScore = SKLabelNode(fontNamed: "Arial")
        topScore.text = "Top Score: \(defaults.objectForKey("p1")!)"
        topScore.fontSize = 30
        topScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 160 )
        
        self.addChild(topScore)
    }
    
    private func addSecondScore() {
        secondScore = SKLabelNode(fontNamed: "Arial")
        secondScore.text = "2nd: \(defaults.objectForKey("p2")!)"
        secondScore.fontSize = 20
        secondScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 110)
        
        self.addChild(secondScore)
    }
    
    private func addThirdScore() {
        thirdScore = SKLabelNode(fontNamed: "Arial")
        thirdScore.text = "3rd: \(defaults.objectForKey("p3")!)"
        thirdScore.fontSize = 20
        thirdScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 80)
        
        self.addChild(thirdScore)
    }
    
    private func addFourthScore() {
        fourthScore = SKLabelNode(fontNamed: "Arial")
        fourthScore.text = "4th: \(defaults.objectForKey("p4")!)"
        fourthScore.fontSize = 20
        fourthScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 50 )
        self.addChild(fourthScore)
    }
    
    private func addFifthScore() {
        fifthScore = SKLabelNode(fontNamed: "Arial")
        fifthScore.text = "5th: \(defaults.objectForKey("p5")!)"
        fifthScore.fontSize = 20
        fifthScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 20)
        
        self.addChild(fifthScore)
    }
    
    
    private func addStartButton() {
        startButton = SKLabelNode(fontNamed: "Arial")
        startButton.text = "Play Again"
        startButton.fontSize = 20
        startButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 140)
        
        self.addChild(startButton)
    }
    
    private func addSettingsButton() {
        settingsButton = SKLabelNode(fontNamed: "Arial")
        settingsButton.text = "Settings"
        settingsButton.fontSize = 20
        settingsButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 190)
        
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
    
    internal class Reachability {
        class func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
                SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
            }
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)
        }
    }
}
