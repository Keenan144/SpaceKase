//
//  GameScene.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 5/29/16.
//  Copyright (c) 2016 Keenan Sturtevant. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let shipCategory: UInt32 = 0x1 << 1
    let rockCategory: UInt32 = 0x1 << 2
    let boundaryCategory: UInt32 = 0x1 << 3
    let healthCategory: UInt32 = 0x2 << 4
    
    var run = Bool()
    var invincible = Bool()
    
    var defaults = NSUserDefaults()
    
    var score = NSInteger()
    var label = SKLabelNode(fontNamed: "Arial")
    
    var ship = SKSpriteNode()
    var rock = SKSpriteNode()
    var health = SKSpriteNode()
    
    var scoreLabel = SKLabelNode(fontNamed: "Arial")
    var exitLabel = SKLabelNode(fontNamed: "Arial")
    var invincibleLabel = SKLabelNode()
    var invincibilityTimer = Int32()
    var invincibilityNSTimer = NSTimer()
    
    var boundary = SKSpriteNode()
    var boundaryColor = UIColor.yellowColor()
    
    var backgroundColorCustom = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    var touchLocation = CGPoint()

    override func didMoveToView(view: SKView) {
        view.showsPhysics = true
        physicsWorld.contactDelegate = self
        self.backgroundColor = backgroundColorCustom
        
        setBoundaries()
        spawnShip()
        start()
    }
    
    func setBoundaries() {
        setBottomBoundary()
        setLeftSideBoundry()
        setRightSideBoundry()
    }
    
    func start() {
        score = 0
        invincible = false
        run = true
        showExitButton()
        showScore()
        rockTimer()
        healthTimer()
        boosterTimer()
    }
    
    func spawnShip(){
        ship = SpaceShip.spawn(shipCategory, rockCategory: rockCategory, frame: self.frame)
        SpaceShip.setShipHealth(defaults.objectForKey("Health") as! Int)
        showHealth()
        self.addChild(ship)
    }
    
    func showExitButton() {
        if run == true {
            exitLabel.text = "exit"
            exitLabel.fontSize = 20
            exitLabel.position = CGPoint(x: self.frame.maxX - 55, y: self.frame.maxY - 80)
            self.addChild(exitLabel)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            let pos = touch.locationInNode(self)
            let node = self.nodeAtPoint(pos)
            
            if node == exitLabel {
                stopRocks()
                endGame()
            } else {
                touchLocation = touch.locationInNode(self)
                ship.position.x = touchLocation.x
                print(ship.position.x)
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            ship.position.x = touchLocation.x
        }
    }
    
    func increaseHealth() {
        if run == true {
            print(SpaceShip.health)
            SpaceShip.health = SpaceShip.health + 5
            print("health increased")
        }
    }
    
    func bumpScore() {
        if run == true {
            print(score)
            score = score + 50
            print("score increased")
        }
    }
    
    func increaseScore() {
        if run == true {
            print(score)
            score = score + 5
            print("score increased")
        }
    }
    
    func randomSpawn() {
        if randomInRange(0.0, hi: 5.0) >= 4.5 {
            if invincible == false {
                let boost = Boost.spawnInvincibility()
                boost.position = CGPoint(x: randomInRange(frame.minX, hi: frame.maxX), y: self.frame.maxY + 100)
                self.addChild(boost)
            }
        } else {
            let boost = Boost.spawnScoreBump()
            boost.position = CGPoint(x: randomInRange(frame.minX, hi: frame.maxX), y: self.frame.maxY + 100)
            self.addChild(boost)
        }
        
    }
    
    func boosterTimer() {
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("randomSpawn"), userInfo: nil, repeats: true)
    }
    
    func rockTimer() {
        _ = NSTimer.scheduledTimerWithTimeInterval((defaults.objectForKey ("SpawnRate") as! NSTimeInterval), target: self, selector: ("spawnRock"), userInfo: nil, repeats: true)
    }
    
    func healthTimer() {
        _ = NSTimer.scheduledTimerWithTimeInterval(5.3, target: self, selector: ("spawnHealth"), userInfo: nil, repeats: true)
    }
    
    func stopRocks() {
        run = false
    }
    
    func spawnRock() {
        if run == true {
            rock = Rock.spawn()
            rock.position = CGPoint(x: randomInRange(frame.minX, hi: frame.maxX), y: self.frame.maxY + 100)
            self.addChild(rock)
        }
    }
    
    func spawnHealth() {
        if run == true {
            health = Health.spawn()
            health.position = CGPoint(x: randomInRange(frame.minX, hi: frame.maxX), y: self.frame.maxY + 100)
            self.addChild(health)
        }
    }
    
    func randomInRange(lo: CGFloat, hi : CGFloat) -> CGFloat {
        
        return lo + CGFloat(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {

        if (contact.bodyA.categoryBitMask == boundaryCategory) {
            print("remove rock {}")
            contact.bodyB.node?.removeFromParent()
            print("increase score {}")
            increaseScore()
            refreshScoreView()
        }
        if (contact.bodyA.categoryBitMask == shipCategory) {
            contact.bodyB.node?.physicsBody?.collisionBitMask = 0
            if (contact.bodyB.node?.name == "Health") {
                contact.bodyB.node?.removeFromParent()
                print("increase Health")
                increaseHealth()
            } else if (contact.bodyB.node?.name == "ScoreBump") {
                contact.bodyB.node?.removeFromParent()
                print("Score Bump")
                bumpScore()
            } else if (contact.bodyB.node?.name == "Invincibility") {
                contact.bodyB.node?.removeFromParent()
                print("Invincibility")
                makeInvincible()
                showInvincibleLabel()
            } else if (contact.bodyB.node?.name == "Rock") {
                print("ROCK CONTACT WITH SHIP")
                if invincible == false {
                    SpaceShip.deductHealth(defaults.objectForKey("Damage") as! Int)
                    if SpaceShip.dead() {
                        stopRocks()
                        endGame()
                    }
                }
            }
            refreshHealthView()
        }
    }
    
    func makeInvincible() {
        if invincible == false {
            invincible = true
            invincibilityTimer = 1
            startInvincibilityTimer()
        }
    }
    
    func incrementInvincibilityTimer() {
        invincibilityTimer = invincibilityTimer + 1
        showInvincibleLabel()
        if invincibilityTimer >= 15 {
            invincibilityNSTimer.invalidate()
            invincible = false
            invincibleLabel.removeFromParent()
        }
        
    }
    
    private func startInvincibilityTimer() {
         invincibilityNSTimer  = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("incrementInvincibilityTimer"), userInfo: nil, repeats: true)
    }
    
    private func showHighScores() {
        defaults.setObject(score, forKey: "lastScore")
    }
    
    private func endGame() {
        showHighScores()
        let skView = self.view as SKView!;
        let gameScene = EndScene(size: (skView?.bounds.size)!)
        let transition = SKTransition.fadeWithDuration (2.0)
        view!.presentScene(gameScene, transition: transition)
        
    }
    
    private func setBottomBoundary() {
        let boundary = Boundary.setBottomBoundary(boundaryCategory, rockCategory: rockCategory, frame: self.frame)
        self.addChild(boundary)
    }
    
    private func setRightSideBoundry() {
        let boundary = Boundary.setRightSideBoundary(boundaryCategory, rockCategory: rockCategory, frame: self.frame)
        self.addChild(boundary)
        
    }
    
    private func setLeftSideBoundry() {
        let boundary = Boundary.setLeftSideBoundary(boundaryCategory, rockCategory: rockCategory, frame: self.frame)
        self.addChild(boundary)
        
    }
    
    private func showHealth() {
        let health = Health.showHealth(label)
        health.fontSize = 20
        health.position = CGPoint(x: self.frame.minX + 55 , y: self.frame.maxY - 40)
        
        self.addChild(health)
    }
    
    func showInvincibleLabel() {
        invincibleLabel.removeFromParent()
        let invLabel = invincibleLabel
        invLabel.text = "Invincible: \(15 - invincibilityTimer)"
        invLabel.fontColor = UIColor.yellowColor()
        invLabel.fontSize = 20
        invLabel.position = CGPoint(x: self.frame.minX + 55 , y: self.frame.maxY - 65)
        
        self.addChild(invLabel)
    }
    
    private func showScore() {
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 20
        scoreLabel.position = CGPoint(x: self.frame.maxX - 75 , y: self.frame.maxY - 40)
        
        self.addChild(scoreLabel)
    }
    
    private func refreshHealthView() {
        label.removeFromParent()
        showHealth()
    }
    
    private func refreshScoreView() {
        scoreLabel.removeFromParent()
        showScore()
    }

}
