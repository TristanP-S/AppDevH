//
//  MainScene.swift
//  GameDevPS
//
//  Created by Tristan Pudell-Spatscheck on 12/16/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
//  Main Game Scene where the actual person is earning the points
import UIKit
import SpriteKit
import GameplayKit
//MARK - Global Variables
var mainSC: SKScene = SKScene()
var points: Int = 0
class MainScene: SKScene {
    //MARK - Variables
    var pointsLbl = SKLabelNode()
    //MARK - Functions
    //Viewdid load
    override func didMove(to view: SKView) {
        mainSC = self
        pointsLbl = self.childNode(withName: "pointsLbl") as! SKLabelNode
        pointsLbl.position = CGPoint(x: 0, y: (self.view?.bounds.maxY)! - 50)
        pointsLbl.text = "Points: \(points)"
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
