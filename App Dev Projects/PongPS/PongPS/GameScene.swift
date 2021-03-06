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
    //difficulty of CPU
    var difficulty : Double = 0
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
        //sets difficulty of AI based on 'game mode'
        switch gamemode {
        case 1:
            difficulty = 0.25
        case 2:
            difficulty = 0.16
        case 3:
            difficulty = 0.13
        default:
            difficulty = 0
            //FLIPS SCORE FOR "ENEMY" by settings its rotation to pi degrees
            enemyScore.zRotation = CGFloat(Double.pi)
        }
    }
    //resets score a position when the game starts
    func gameStart(){
        ball.color = ballColor
        playerPaddle.position.x = 0
        playerPaddle.position.y = -600
        playerPaddle.color = bottomColor
        enemyPaddle.position.x = 0
        enemyPaddle.position.y = 600
        enemyPaddle.color = topColor
        playerScore.text = "0"
        enemyScore.text = "0"
        enemyScore.zRotation = 0
        resetPositions()
    }
    //resets all sprite poisitons
    func resetPositions(){
        ball.position.x = 0
        ball.position.y = 0
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
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
    func reset(){
        //notifies GameVC that buttons should toggle on and music should change
        gameVC.restartGame()
        //resets game
        score1 = Int(playerScore.text!)!
        score2 = Int(enemyScore.text!)!
        //Checks to see if each difficulty was cleared for achievment purposes + if game was won, then sets values accordingly and saves them w/ persistance
        if(score1 > score2 && difficulty != 0){
            if(easyDubs == false && difficulty == 0.25){
                easyDubs = true
            } else if (goodPlayer == false && difficulty == 0.16){
                goodPlayer = true
            } else if (godGamer == false && difficulty == 0.13){
                godGamer = true
            }
            breadWinner += 1
            UserDefaults.standard.set(easyDubs, forKey: "easyDubs")
            UserDefaults.standard.set(goodPlayer, forKey: "goodPlayer")
            UserDefaults.standard.set(godGamer, forKey: "godGamer")
            UserDefaults.standard.set(breadWinner, forKey: "breadWinner")
        }
        let scene = SKScene(fileNamed: "TitleScene")
        // Set the scale mode to scale to fit the window
        scene!.scaleMode = .aspectFill
        // Present the scene
        view!.presentScene(scene)
    }
    //finger touched screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            //gets finger location and moves to it with a small delay
            let location = touch.location(in: self)
            if(gamemode != 4){ //short circuit for non-multiplayer
                playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.05))
            } else { //multiplayer
                if(location.y > 0){ //if top screen player taps
                    enemyPaddle.run(SKAction.moveTo(x: location.x, duration: 0.05))
                } else { //if bottom screen player taps
                   playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
            }
        }
    }
    //finger moves
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            //gets finger location and moves to it with a small delay
            let location = touch.location(in: self)
            if(gamemode != 4){ //short circuit for non-multiplayer
                playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.05))
            } else { //multiplayer
                if(location.y > 0){ //if top screen player taps
                    enemyPaddle.run(SKAction.moveTo(x: location.x, duration: 0.05))
                } else { //if bottom screen player taps
                   playerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //moves the enemy, changes the duration to change the difficulty
        if(gamemode != 4){
        enemyPaddle.run(SKAction.moveTo(x: ball.position.x, duration: TimeInterval(difficulty)))
        }
        //makes the ball slowly get faster
        if(ball.physicsBody!.velocity.dy > 0){
            ball.physicsBody?.applyForce(CGVector(dx: 0, dy: 2))
        } else {
            ball.physicsBody?.applyForce(CGVector(dx: 0, dy: -2))
        }
        //win conditions / adding points
        if(ball.position.y <= playerPaddle.position.y - 30 && !god){
            if(enemyScore.text == "9"){
                reset()
            } else {
            addScore(player: false)
            resetPositions()
            }
        } else if (ball.position.y >= enemyPaddle.position.y + 30 && !eGod){
            if(playerScore.text == "9"){
                reset()
            } else {
            addScore(player: true)
            resetPositions()
            }
        }
    }
}
