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
var mazeSize: Int = 5
class GameScene: SKScene {
    //MARK - Nodes
    var mazeBckg = SKSpriteNode()
    var player = SKSpriteNode()
    var timeLbl = SKLabelNode()
    //size of maze set here
    var maze = [SKSpriteNode?](repeating: nil, count: mazeSize*mazeSize)
    var TwoDmaze = [[Bool]]()
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
        mazeBckg.size.width = 760
        //setupMaze()
    }
    //generates a maze
    func genMaze(){
        print(maze.count)
        var i = 0
        //actually makes maze
        while(i <= maze.count - 1){
            //Takes screen size / width to make each piece one/(value set by "maze" at top) of the screen
            let width: CGFloat = 750 / CGFloat(mazeSize)
            let height: CGFloat = 25 //set size because it works better, causes issues w/ small screens + large mazes
            let wall = SKSpriteNode(color: .black, size: CGSize(width: width, height: height))
            wall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            wall.isHidden = false
            wall.zPosition = 4
            wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
            wall.physicsBody?.restitution = 0
            wall.physicsBody?.friction = 0
            wall.physicsBody?.isDynamic = false
            //sets up x+y location based on row count and which row this is on
            //locations (ONLY positive)
            let xLoc: CGFloat = (mazeBckg.size.width / CGFloat((mazeSize/2))) * CGFloat(i/mazeSize)
            let yLoc: CGFloat = (mazeBckg.size.height / CGFloat(mazeSize/2)) * CGFloat(i/mazeSize)
            if((i/mazeSize) > (mazeSize/2)){ //if positive on x
                wall.position.x = xLoc
            }
            else{ //if negative on x
                wall.position.x = -xLoc
            }
            if(i > ((mazeSize^2)/2)){ //if positive on y
                wall.position.x = yLoc
            }
            else{ //if negative on y
                wall.position.y = yLoc
            }
            //adds wall to maze array
            maze[i] = wall
            i += 1
        }
        //adds all walls that were generated
        for wall in maze{
            if(wall != nil){ //failsafe (if wall improperly generated)
            addChild(wall!)
            }
        }
    }
    //sets up the generated maze
    func setupMaze(){
        //makes 5*5 maze all set to true
        var TwoDmaze = [Array](repeating: [Bool](repeating: true, count: mazeSize), count: mazeSize)
        var win = false
        var row = Int.random(in: 0...mazeSize - 1) // starts from bottom
        var column = 0
        //deletes certain walls to allow player through maze
        while(!win){
            //deleted wall selected
            TwoDmaze[row][column] = false
            if(column == 4){ // if top row
                win = true
            } else { //if not top row (end)
                if(row != 0 && row != 4){ //if not on sides of maze
                    let delWall = Int.random(in: 1...3)
                    if(delWall == 1){
                        column += 1
                    }
                    else if(delWall == 2){
                        row += 1
                    }
                    else{
                        row += -1
                    }
                } else if(row != 0){ //if on right side of maze
                    let delWall = Int.random(in: 1...2)
                    if(delWall == 1){
                        column += 1
                    } else {
                        row += -1
                    }
                }
                else{ //if on left side of maze
                    let delWall = Int.random(in: 1...2)
                    if(delWall == 1){
                        column += 1
                    } else {
                        row += 1
                    }
                }
            }
        }
        //sets value set in 2dmaze in place
        var i = 0
        var j = 0
        while(i < mazeSize - 1){
            while(j < mazeSize - 1){
                let location = ((i+1)*(j+1) - 1)
                if(!TwoDmaze[i][j]){ //if not supposed to exist
                    maze[location]!.isHidden = true
                } else {
                    maze[location]!.isHidden = false
                }
                j += 1
            }
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
