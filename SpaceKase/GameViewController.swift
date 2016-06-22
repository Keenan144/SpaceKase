//
//  GameViewController.swift
//  SpaceKase
//
//  Created by Keenan Sturtevant on 5/29/16.
//  Copyright (c) 2016 Keenan Sturtevant. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        let skView = self.view as! SKView;
        if skView.scene != nil {
            skView.showsFPS = true;
            skView.showsNodeCount = true;
            skView.showsPhysics = true;
            // Create and configure the scene
            
            let scene:SKScene = MenuScene(size: skView.bounds.size);
            //    Objective-C code in next 2 lines
            //    SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
            //    scene.scaleMode = SKSceneScaleModeAspectFill;
            
            // Present Scene
            skView.presentScene(scene)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = MenuScene(fileNamed: "MenuScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            skView.presentScene(scene)
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.All
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
