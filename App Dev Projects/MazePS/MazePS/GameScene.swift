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
//MARK - Global Vars
var time: Double = 0
var selected = -1
var winner = false
var gameScene = GameScene()
var gameVC = GameViewController()
class GameScene: SKScene {
    //MARK - Nodes
    var mazeBckg = SKSpriteNode()
    var player = SKSpriteNode()
    var timeLbl = SKLabelNode()
    //MARK - Setup
    override func didMove(to view: SKView) {
        //sets background to white and this to gameScene
        scene?.backgroundColor = UIColor(ciColor: .white)
        gameScene = self
        //attatches sprites to variables
        player = self.childNode(withName: "player") as! SKSpriteNode
        //sets up physics so player doesn't bounce, rotate, be affected by friction/gravity, not tilted, proper layerings
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25))
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.angularDamping = 0
        player.physicsBody?.linearDamping = 0
        player.physicsBody?.restitution = 0
        player.physicsBody?.friction = 0
        player.zRotation = 0
        player.zPosition = 2
        mazeBckg = self.childNode(withName: "mazeBckg") as! SKSpriteNode
        mazeBckg.zPosition = 1
        timeLbl = self.childNode(withName: "timeLbl") as! SKLabelNode
        timeLbl.zPosition = 3
        //sets up border of screen as border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0
        self.physicsBody = border
        //loads "next level" (first level), resets since this func. is only called in first time load
        selected = -1
        nextLv()
    }
    //MARK - Normal functions
    //loads next level
    func nextLv(){
        time = 0
        winner = false
        player.position.y = -640
        player.position.x = 0
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        mazeBckg.color = UIColor(ciColor: .white)
        mazeBckg.position.x = 0
        mazeBckg.position.y = 0
        mazeBckg.size.height = 1334
        mazeBckg.size.width = 750
    }
    //generates a maze
    func genMaze(){
        
    }
    //makes a basic alert with an ok button and presents it
    func makeAlert(message: String){
        winner = true
        let alertMessage = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { action in
            //call any needed functions here
            print("OK pressed")
            self.nextLv()
        }
        alertMessage.addAction(okayAction)
        gameVC.present(alertMessage, animated: true)
    }
    //MARK - Movement
    func movePlayer(direction : Int){
        switch direction {
            case 0: //stop moving
                self.player.physicsBody?.velocity = (CGVector(dx: 0, dy: 0))
            case 1: //up
                self.player.physicsBody?.velocity = (CGVector(dx: 0, dy: 200))
            case 2: //down
                self.player.physicsBody?.velocity = (CGVector(dx: 0, dy: -200))
            case 3: //left
                self.player.physicsBody?.velocity = (CGVector(dx: 200, dy: 0))
            default: //right
                self.player.physicsBody?.velocity = (CGVector(dx: -200, dy: 0))
        }
    }
    //MARK - Update Functions
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        time += 1/60
        if(!winner){
        timeLbl.text = "Time: \(Int(time))"
        }
        if(player.position.y > 605){
            makeAlert(message: "You beat the Maze with a time of \(Int(time))!")
        }
    }
}
