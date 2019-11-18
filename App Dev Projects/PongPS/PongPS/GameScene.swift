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
    //variable to see if player is the one who scored
    var player = true
    override func didMove(to view: SKView) {
        //connects gamescene to code
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        playerPaddle = self.childNode(withName: "playerPaddle") as! SKSpriteNode
        enemyPaddle = self.childNode(withName: "enemyPaddle") as! SKSpriteNode
        playerScore = self.childNode(withName: "playerScore") as! SKLabelNode
        enemyScore = self.childNode(withName: "enemyScore") as! SKLabelNode
        gameStart()
        //sets boundaries of app to border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
    //resets score a position when the game starts
    func gameStart(){
        playerScore.text = "0"
        enemyScore.text = "0"
        resetPositions()
    }
    //resets all sprite poisitons
    func resetPositions(){
        ball.position.x = 0
        ball.position.y = 0
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        playerPaddle.position.x = 0
        playerPaddle.position.y = -600
        enemyPaddle.position.x = 0
        enemyPaddle.position.y = 600
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
    func addScore(player: Bool){
        if(player){
        playerScore.text = String(Int(playerScore.text!)! + 1)
        } else {
        enemyScore.text = String(Int(enemyScore.text!)! + 1)
        }
    }
    //finger touched screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            //gets finger location and moves to it with a small delay
            let location = touch.location(in: self)
            playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
    }
    //finger moves
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            //gets finger location and moves to it with a small delay
            let location = touch.location(in: self)
            playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //moves the enemy, changes the duration to change the difficulty
        enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
        //makes the ball slowly get faster
        if(ball.physicsBody!.velocity.dy > 0){
            ball.physicsBody?.applyForce(CGVector(dx: 0, dy: 2))
        } else {
            ball.physicsBody?.applyForce(CGVector(dx: 0, dy: -2))
        }
        if(ball.position.y <= playerPaddle.position.y - 30){
            addScore(player: false)
            resetPositions()
        } else if (ball.position.y >= enemyPaddle.position.y + 30){
            addScore(player: true)
            resetPositions()
        }
    }
}
