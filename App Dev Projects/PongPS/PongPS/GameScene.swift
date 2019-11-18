//
//  GameScene.swift
//  PongPS
//
//  Created by Tristan Pudell-Spatscheck on 11/18/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //sets up variables for each item
    var ball = SKSpriteNode()
    var playerPaddle = SKSpriteNode()
    var enemyPaddle = SKSpriteNode()
    var playerScore = SKLabelNode()
    var enemyScore = SKLabelNode()
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        //connects gamescene to code
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        playerPaddle = self.childNode(withName: "playerPaddle") as! SKSpriteNode
        enemyPaddle = self.childNode(withName: "enemyPaddle") as! SKSpriteNode
        playerScore = self.childNode(withName: "playerScore") as! SKLabelNode
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        //pushes ball in one of 4 random directions
        let direction = Int.random(in: 1...4)
        switch direction {
        case 1:
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))  //down right
        case 2:
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: 20))  //up left
        case 3:
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: -20)) //down left
        default:
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))  //up right
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
