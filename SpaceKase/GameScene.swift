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
    
    var score = NSInteger()
    var label = SKLabelNode(fontNamed: "Arial")
    
    var ship = SKSpriteNode()
    var rock = SKSpriteNode()
    var health = SKSpriteNode()
    
    var boosterRateTimer = NSTimer()
    var rockRateTimer = NSTimer()
    var healthRateTimer = NSTimer()
    
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
        view.showsPhysics = false
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
        Helper.toggleRun(true)
        showExitButton()
        showScore()
        rockTimer()
        healthTimer()
        boosterTimer()
    }
    
    func spawnShip(){
        ship = SpaceShip.spawn(shipCategory, rockCategory: rockCategory, frame: self.frame)
        SpaceShip.setShipHealth(Helper.setShipHealth())
        showHealth()
        self.addChild(ship)
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
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if (contact.bodyA.categoryBitMask == boundaryCategory) {
            contact.bodyB.node?.removeFromParent()
            print("GAMESCENE: scoreIncresed")
            increaseScore()
            refreshScoreView()
        }
        if (contact.bodyA.categoryBitMask == shipCategory) {
            contact.bodyB.node?.physicsBody?.collisionBitMask = 0
            if (contact.bodyB.node?.name == "Health") {
                contact.bodyB.node?.removeFromParent()
                increaseHealth()
            } else if (contact.bodyB.node?.name == "ScoreBump") {
                contact.bodyB.node?.removeFromParent()
                bumpScore()
            } else if (contact.bodyB.node?.name == "Invincibility") {
                contact.bodyB.node?.removeFromParent()
                makeInvincible()
                showInvincibleLabel()
            } else if (contact.bodyB.node?.name == "Rock") {
                if Helper.isInvincible() == false {
                    SpaceShip.deductHealth(Helper.deductHealth())
                    if SpaceShip.dead() {
                        stopRocks()
                        endGame()
                    }
                }
            }
            refreshHealthView()
        }
    }
    
    func increaseHealth() {
        if Helper.canRun() {
            SpaceShip.health = SpaceShip.health + 5
        }
    }
    
    func bumpScore() {
        if Helper.canRun() {
            score = score + 50
        }
    }
    
    func increaseScore() {
        if Helper.canRun() {
            score = score + 5
        }
    }
    
    func spawnRock() {
        if Helper.canRun() {
            rock = Rock.spawn()
            rock.position = Helper.randomSpawnPoint(frame.minX, valueHighX: frame.maxX, valueY: frame.maxY)
            self.addChild(rock)
        }
    }
    
    func spawnHealth() {
        if Helper.canRun() {
            health = Health.spawn()
            health.position = Helper.randomSpawnPoint(frame.minX, valueHighX: frame.maxX, valueY: frame.maxY)
            self.addChild(health)
        }
    }
    
    func randomSpawn() {
        if Helper.canRun() {
            if Helper.randomSpawn() == 1 {
                let boost = Boost.spawnInvincibility()
                boost.position = Helper.randomSpawnPoint(frame.minX, valueHighX: frame.maxX, valueY: self.frame.maxY)
                self.addChild(boost)
            } else {
                let boost = Boost.spawnScoreBump()
                boost.position = Helper.randomSpawnPoint(frame.minX, valueHighX: frame.maxX, valueY: self.frame.maxY)
                self.addChild(boost)
            }
        }
    }
    
    func boosterTimer() {
        boosterRateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("randomSpawn"), userInfo: nil, repeats: true)
    }
    
    func rockTimer() {
        rockRateTimer = NSTimer.scheduledTimerWithTimeInterval(Helper.rockSpawnRate(), target: self, selector: ("spawnRock"), userInfo: nil, repeats: true)
    }
    
    func healthTimer() {
        healthRateTimer = NSTimer.scheduledTimerWithTimeInterval(5.3, target: self, selector: ("spawnHealth"), userInfo: nil, repeats: true)
    }
    
    func stopRocks() {
        Helper.toggleRun(false)
    }
    
    
    private func showHighScores() {
        Helper.setLastScore(score)
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
        if 15 - invincibilityTimer > 0 {
            invincibleLabel.removeFromParent()
            let invLabel = invincibleLabel
            invLabel.text = "Invincible: \(15 - invincibilityTimer)"
            invLabel.fontColor = UIColor.yellowColor()
            invLabel.fontSize = 20
            invLabel.position = CGPoint(x: self.frame.minX + 55 , y: self.frame.maxY - 65)
            
            self.addChild(invLabel)
        } else {
            invincibleLabel.removeFromParent()
        }
    }
    
    private func showScore() {
        scoreLabel.text = "Score: \(score)"
        scoreLabel.fontSize = 20
        scoreLabel.position = CGPoint(x: self.frame.maxX - 75 , y: self.frame.maxY - 40)
        
        self.addChild(scoreLabel)
    }
    
    func showExitButton() {
        if Helper.canRun() {
            exitLabel.text = "exit"
            exitLabel.fontSize = 20
            exitLabel.position = CGPoint(x: self.frame.maxX - 55, y: self.frame.maxY - 80)
            self.addChild(exitLabel)
        }
    }
    
    private func refreshHealthView() {
        label.removeFromParent()
        showHealth()
        print("GAMESCENE: refreshHealthView")
    }
    
    private func refreshScoreView() {
        scoreLabel.removeFromParent()
        showScore()
        print("GAMESCENE: refreshScoreView")
    }
    
    private func endGame() {
        showHighScores()
        ship.removeAllActions()
        rock.removeAllActions()
        invincibleLabel.removeAllActions()
        let skView = self.view as SKView!;
        let gameScene = EndScene(size: (skView?.bounds.size)!)
        let transition = SKTransition.fadeWithDuration (2.0)
        boosterRateTimer.invalidate()
        rockRateTimer.invalidate()
        healthRateTimer.invalidate()
        view!.presentScene(gameScene, transition: transition)
    }
    
    private func makeInvincible() {
        if Helper.invincible == false {
            Helper.toggleInvincibility(true)
            invincibilityTimer = 1
            startInvincibilityTimer()
            print("GAMESCENE: makeInvincible")
        }
    }
    
    @objc private func incrementInvincibilityTimer() {
        invincibilityTimer = invincibilityTimer + 1
        showInvincibleLabel()
        if invincibilityTimer >= 15 {
            invincibilityNSTimer.invalidate()
            Helper.toggleInvincibility(false)
            print("GAMESCENE: incrementInvincibilityTimer")
        }
    }
    
    private func returnInvincibilityTime() -> Int32 {
        return invincibilityTimer
    }
    
    private func startInvincibilityTimer() {
        invincibilityNSTimer  = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: (#selector(GameScene.incrementInvincibilityTimer)), userInfo: nil, repeats: true)
        print("GAMESCENE: startInvincibilityTimer")
    }

}
