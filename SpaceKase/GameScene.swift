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
    
    var timer = NSTimer()
    var run = Bool()
    
    var ship = SKSpriteNode?()
    
    var rock = SKSpriteNode?()
    
    var boundary = SKSpriteNode?()
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
        run = true
        spawnRock()
        rockTimer()
    }
    
    func spawnShip(){
        ship = SpaceShip.spawn(shipCategory, rockCategory: rockCategory, frame: self.frame)
        SpaceShip.setShipHealth(100)
        self.addChild(ship!)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            ship!.position.x = touchLocation.x
            print(ship!.position.x)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            ship!.position.x = touchLocation.x
        }
    }
    
    func rockTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("spawnRock"), userInfo: nil, repeats: true)
    }
    
    func stopRocks() {
        run = false
    }
    
    func spawnRock() {
        if run == true {
            rock = Rock.spawn()
            rock?.position = CGPoint(x: randomInRange(CGRectGetMinX(frame), hi: CGRectGetMaxX(frame)), y: CGRectGetMaxY(self.frame) + 100)
            self.addChild(rock!)
        }
    }
    
    func randomInRange(lo: CGFloat, hi : CGFloat) -> CGFloat {
        
        return lo + CGFloat(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {

        if (contact.bodyA.categoryBitMask == boundaryCategory) {
            print("remove rock {}")
            contact.bodyB.node?.removeFromParent()
        }
        if (contact.bodyA.categoryBitMask == shipCategory) {
            contact.bodyB.node?.physicsBody?.collisionBitMask = 0
            print("ROCK CONTACT WITH SHIP")
            SpaceShip.deductHealth(20)
            if SpaceShip.dead() {
                stopRocks()
                endGame()
            }
        }
    }
    
    private func endGame() {
        let skView = self.view as SKView!;
        let gameScene = MenuScene(size: skView.bounds.size)
        let transition = SKTransition.fadeWithDuration(2.0)
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


}
