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
var selected = -1
var mazes = [SKTexture(image: UIImage(named: "maze1")!)]
var gameScene = GameScene()
class GameScene: SKScene {
    var mazeImg = SKSpriteNode()
    var player = SKSpriteNode()
    var timeLbl = SKLabelNode()
    override func didMove(to view: SKView) {
        //sets background to white and this to gameScene
        scene?.backgroundColor = UIColor(ciColor: .white)
        gameScene = self
        //attatches sprites to variables
        player = self.childNode(withName: "player") as! SKSpriteNode
        mazeImg = self.childNode(withName: "mazeBckg") as! SKSpriteNode
        timeLbl = self.childNode(withName: "timeLbl") as! SKLabelNode
        //sets up border of screen as border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        //loads "next level" (first level), resets since this func. is only called in first time load
        selected = -1
        nextLv()
    }
    func nextLv(){
        selected += 1
        player.position.y = -640
        player.position.x = 0
        mazeImg.texture = mazes[selected]
        mazeImg.position.x = 0
        mazeImg.position.y = 0
        mazeImg.size.height = 1200
        mazeImg.size.width = 750
    }
    func movePlayer(direction : Int){
        print("called")
        switch direction {
            case 1: //up
                self.player.physicsBody?.applyForce(CGVector(dx: 0, dy: 5))
            case 2: //down
                self.player.physicsBody?.applyForce(CGVector(dx: 0, dy: -5))
            case 3: //left
                self.player.physicsBody?.applyForce(CGVector(dx: -5, dy: 0))
            default: //right
                self.player.physicsBody?.applyForce(CGVector(dx: 5, dy: 0))
        }
        print("moved")
    }
    override func update(_ currentTime: TimeInterval) {
        time += 1/60
        timeLbl.text = "Time: \(Int(time))"
        // Called before each frame is rendered
    }
}
