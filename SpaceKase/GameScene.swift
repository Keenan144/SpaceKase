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
    let boundryCategory: UInt32 = 0x1 << 3
    
    var timer = NSTimer()
    var run = Bool()
    
    var ship = SpaceShip.load()
    
    var rock = SKSpriteNode?()
    var rockColor = UIColor.blueColor()
    var rockSize = CGSize(width: 50, height: 20)
    
    var boundry = SKSpriteNode?()
    var boundryColor = UIColor.yellowColor()
    
    var backgroundColorCustom = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    var touchLocation = CGPoint()

    override func didMoveToView(view: SKView) {
        view.showsPhysics = true
        physicsWorld.contactDelegate = self
        self.backgroundColor = backgroundColorCustom
        setBottomBoundry()
        setRightSideBoundry()
        setLeftSideBoundry()
        spawnShip()
        start()
    }
    
    func setBottomBoundry() {
        boundry = SKSpriteNode(color: boundryColor, size: CGSize(width: CGRectGetWidth(self.frame), height: 1))
        boundry?.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: CGRectGetWidth(self.frame), height: 1))
        boundry?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMinY(self.frame))
        boundry?.physicsBody?.dynamic = false
        boundry?.physicsBody?.categoryBitMask = boundryCategory
        boundry?.physicsBody?.contactTestBitMask = rockCategory
        boundry?.physicsBody?.collisionBitMask = 0;
        boundry?.physicsBody?.usesPreciseCollisionDetection = true
            self.addChild(boundry!)
    }
    
    func setRightSideBoundry() {
        boundry = SKSpriteNode(color: boundryColor, size: CGSize(width: 1, height: CGRectGetHeight(self.frame)))
        boundry?.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: CGRectGetHeight(self.frame)))
        boundry?.physicsBody?.dynamic = false
        boundry?.physicsBody?.categoryBitMask = boundryCategory
                boundry?.physicsBody?.contactTestBitMask = rockCategory
        boundry?.physicsBody?.collisionBitMask = 0;
        boundry?.physicsBody?.usesPreciseCollisionDetection = true
        
        boundry?.position = CGPoint(x: CGRectGetMaxX(self.frame), y: CGRectGetMidY(self.frame))
            self.addChild(boundry!)

    }
    
    func setLeftSideBoundry() {
        boundry = SKSpriteNode(color: boundryColor, size: CGSize(width: 1, height: CGRectGetHeight(self.frame)))
        boundry?.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 1, height: CGRectGetHeight(self.frame)))
        boundry?.physicsBody?.dynamic = false
        boundry?.physicsBody?.categoryBitMask = boundryCategory
                boundry?.physicsBody?.contactTestBitMask = rockCategory
        boundry?.physicsBody?.collisionBitMask = 0;
        boundry?.physicsBody?.usesPreciseCollisionDetection = true
        
        boundry?.position = CGPoint(x: CGRectGetMaxX(self.frame), y: CGRectGetMidY(self.frame))
            self.addChild(boundry!)
        
    }
    
    func start() {
        run = true
        spawnRock()
        rockTimer()
    }
    
    func spawnShip(){
        ship = SpaceShip.spawn(ship, shipCategory: shipCategory, rockCategory: rockCategory)
//        ship.texture = SKTexture(imageNamed: "Spaceship")
        ship.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 150)
        self.addChild(ship)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            ship.position.x = touchLocation.x
            print(ship.position.x)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches{
            touchLocation = touch.locationInNode(self)
            ship.position.x = touchLocation.x
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    func rockTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("spawnRock"), userInfo: nil, repeats: true)
    }
    
    func stopRocks() {
        run = false
    }
    
    func spawnRock() {
        if run == true {
            rock = SKSpriteNode(color: rockColor, size: rockSize)
            rock?.physicsBody = SKPhysicsBody(rectangleOfSize: rockSize)
            rock?.physicsBody?.dynamic = true
            rock?.position = CGPoint(x: randomInRange(CGRectGetMinX(frame), hi: CGRectGetMaxX(frame)), y: CGRectGetMaxY(self.frame) + 100)
            rock?.physicsBody?.usesPreciseCollisionDetection = true
//            rock?.physicsBody!.categoryBitMask = rockCategory
            self.addChild(rock!)
//            print("Spawn Rock \(rock?.position.x)")
        }
    }
    
    func randomInRange(lo: CGFloat, hi : CGFloat) -> CGFloat {
        
        return lo + CGFloat(arc4random_uniform(UInt32(hi - lo + 1)))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {

        if (contact.bodyA.categoryBitMask == boundryCategory) {
            print("remove rock {}")
            contact.bodyB.node?.removeFromParent()
        }
        if (contact.bodyA.categoryBitMask == shipCategory) {
            print("ROCK CONTACT WITH SHIP")
            stopRocks()
            endGame()
        }
    }
    
    private func endGame() {
        let skView = self.view as SKView!;
        let gameScene = MenuScene(size: skView.bounds.size)
        let transition = SKTransition.fadeWithDuration(2.0)
        view!.presentScene(gameScene, transition: transition)
    }


}
