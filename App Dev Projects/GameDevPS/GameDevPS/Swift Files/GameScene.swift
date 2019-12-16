//
//  GameScene.swift
//  GameDevPS
//
//  Created by Tristan Pudell-Spatscheck on 12/16/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
import UIKit
import SpriteKit
import GameplayKit
//MARK - Global Variables
var points: Int = 0
class GameScene: SKScene {
    //MARK - Variables
    var pointsLbl = SKLabelNode()
    //MARK - Functions
    //Viewdid load
    override func didMove(to view: SKView) {
        pointsLbl = self.childNode(withName: "pointsLbl") as! SKLabelNode
    }
    //Detects Tap (Beggining)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        points += 1
        print("Location: \(location), Points: \(points)")
        pointsLbl.text = "Points: \(points)"
    }
    //Update function
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
