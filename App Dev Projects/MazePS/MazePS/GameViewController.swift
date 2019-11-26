//
//  GameViewController.swift
//  MazePS
//
//  Created by Tristan Pudell-Spatscheck on 11/26/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    @IBOutlet weak var upArrow: UIButton!
    @IBOutlet weak var downArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var leftArrow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loads game scene
        if let view = self.view as! SKView? {
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
    //normal functions
    //up button pressed
    @IBAction func upPressed(_ sender: Any) {
        gameScene.movePlayer(direction: 1)
    }
    //down button pressed
    @IBAction func downPressed(_ sender: Any) {
        gameScene.movePlayer(direction: 2)
    }
    //right button pressed
    @IBAction func rightPressed(_ sender: Any) {
        gameScene.movePlayer(direction: 3)
    }
    //left button pressed
    @IBAction func leftPressed(_ sender: Any) {
        gameScene.movePlayer(direction: 4)
    }
    
    //default functions
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
