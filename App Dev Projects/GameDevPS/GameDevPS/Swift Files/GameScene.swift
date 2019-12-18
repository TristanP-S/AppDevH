//
//  GameScene.swift
//  GameDevPS
//
//  Created by Tristan Pudell-Spatscheck on 12/18/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
//  The first minigame scene
import UIKit
import SpriteKit
import GameplayKit
//MARK - Global Variables
var gameSC: SKScene = SKScene()
class GameScene: SKScene {
    //MARK - Variables
    var pointsLbl = SKLabelNode()
    //MARK - Functions
    //Viewdid load
    override func didMove(to view: SKView) {
        gameSC = self
        pointsLbl = self.childNode(withName: "pointsLbl") as! SKLabelNode
        pointsLbl.position = CGPoint(x: 0, y: (self.view?.bounds.maxY)! - 50)
        pointsLbl.text = "Points: \(points)"
    }
    //Update function
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
