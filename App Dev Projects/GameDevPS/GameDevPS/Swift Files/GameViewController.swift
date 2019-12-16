//
//  GameViewController.swift
//  GameDevPS
//
//  Created by Tristan Pudell-Spatscheck on 12/16/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
var gameVC = GameViewController()
class GameViewController: UIViewController {
    //MARK - Outlets
    @IBOutlet weak var gameView: SKView!
    //MARK - Variables
    override func viewDidLoad() {
        super.viewDidLoad()
        gameVC = self
        if let view = self.gameView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    //MARK - Default Functions
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
