//
//  GameViewController.swift
//  GyroGamePS
//
//  Created by Tristan Pudell-Spatscheck on 2/11/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    //sets up gamescene
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
    }
    //makes it so screen doesn't rotate
    override var shouldAutorotate: Bool {
        return false
    }
    //makes it so screen is always in portait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }
    //idk what this is, but it was here by default
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
