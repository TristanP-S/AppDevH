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
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
