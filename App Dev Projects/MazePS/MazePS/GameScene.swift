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
    //size of maze set here
    var maze = [SKSpriteNode?](repeating: nil, count: 5*5)
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
        border.isDynamic = false
        self.physicsBody = border
        //loads "next level" (first level), resets since this func. is only called in first time load
        selected = -1
        genMaze()
        nextLv()
    }
    //MARK - Normal functions
    //loads next level
    func nextLv(){
        winner = false
        player.position.y = -640
        player.position.x = 0
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        mazeBckg.color = UIColor(ciColor: .white)
        mazeBckg.position.x = 0
        mazeBckg.position.y = 0
        mazeBckg.size.height = 1334
        mazeBckg.size.width = 750
        setupMaze()
    }
    //generates a maze
    func genMaze(){
        var i = 0
        //actually makes maze
        while(i <= maze.count - 1){
            let wall = SKSpriteNode()
            wall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            //Takes screen size / width to make each piece one/(value set by "maze" at top) of the screen
            var width: CGFloat = (UIScreen.main.bounds.width) / (sqrt(CGFloat(maze.count)))
            var height: CGFloat = (UIScreen.main.bounds.height - 134) / (sqrt(CGFloat(maze.count))) //subtract so there's extra room on top+bottom of screen
            width *= CGFloat(i+1)
            height *= 1
            wall.position.y = 0
            wall.position.x = 0
            wall.color = UIColor(ciColor: .black)
            wall.isHidden = false
            wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
            wall.physicsBody?.restitution = 0
            wall.physicsBody?.friction = 0
            wall.physicsBody?.isDynamic = false
            wall.zPosition = 4
            maze[i] = wall
            i += 1
        }
        //adds all walls that were generated
        for wall in maze{
            if(wall != nil){
            addChild(wall!)
            }
        }
    }
    //sets up the generated maze
    func setupMaze(){
        var i = 0
        //deletes certain walls to allow player through maze
        while(i < maze.count){
            i += 1
        }
    }
    //makes a basic alert with an ok button and presents it
    func makeAlert(message: String){
        let alertMessage = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { action in
            //call any needed functions here
            print("OK pressed")
            time = 0
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
        if(player.position.y > 605){
            winner = true
            makeAlert(message: "You beat the Maze with a time of \(Int(time)) seeconds!")
            self.nextLv()
        }
        if(!winner){
        timeLbl.text = "Time: \(Int(time))"
        }
    }
}
