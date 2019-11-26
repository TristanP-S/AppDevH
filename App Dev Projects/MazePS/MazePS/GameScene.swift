//
//  GameScene.swift
//  MazePS
//
//  Created by Tristan Pudell-Spatscheck on 11/26/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
import UIKit
import SpriteKit
import GameplayKit
var time: Double = 0
var selected = 0
var mazes = [SKTexture(image: UIImage(named: "maze1")!)]
class GameScene: SKScene {
    var mazeImg = SKSpriteNode()
    var ball = SKSpriteNode()
    var timeLbl = SKLabelNode()
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        mazeImg = self.childNode(withName: "mazeBckg") as! SKSpriteNode
        timeLbl = self.childNode(withName: "timeLbl") as! SKLabelNode
        //sets up border of screen as border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        nextLv()
    }
    func nextLv(){
        ball.position.y = -640
        ball.position.x = 0
        mazeImg.texture = mazes[selected]
        mazeImg.position.x = 0
        mazeImg.position.y = 0
        mazeImg.size.height = 1200
        mazeImg.size.width = 750
    }
    override func update(_ currentTime: TimeInterval) {
        time = time + 0.1
        timeLbl.text = "Time: \(Int(time))"
        // Called before each frame is rendered
    }
}
