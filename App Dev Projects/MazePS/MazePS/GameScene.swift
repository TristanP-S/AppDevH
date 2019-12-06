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
var delIndexes: [Int] = []
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
        setupMaze() //actually sets up a real maze
    }
    //generates a maze
    func genMaze(){
        var i = 0
        let halfMaze: Int = Int(mazeSize / 2) //halfMaze is just 1/2 of the maze. It is used to calculate a lot.
        //actually makes maze
        while(i <= maze.count - 1){
            //Takes screen size / width to make each piece one/(value set by "maze" at top) of the screen
            let width: CGFloat = 760 / CGFloat(mazeSize)
            let height: CGFloat = 25 //set size because it works better, causes issues w/ small screens + large mazes
            let wall = SKSpriteNode(color: .black, size: CGSize(width: width, height: height))
            wall.name = "wall\(i)"
            wall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            wall.isHidden = false
            wall.zPosition = 4
            wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
            wall.physicsBody?.restitution = 0
            wall.physicsBody?.friction = 0
            wall.physicsBody?.affectedByGravity = false
            wall.physicsBody?.isDynamic = false
            wall.physicsBody?.collisionBitMask = 0
            wall.physicsBody?.contactTestBitMask = 0
            wall.isHidden = true
            //sets up x+y location based on row count and which row this is on
            if((i%mazeSize) > halfMaze){ //if positive on x
                //position set to 1/column # of positive side * column - 1/2(column #)
                wall.position.x = CGFloat((355 / halfMaze) * ((i % mazeSize) - halfMaze))
            }
            else if((i % mazeSize) == 0){ //if middle of x (0), only for odd # sizes
                wall.position.x = 0
            }
            else{ //if negative on x
                //position set to 1/column # of negative side * column
                wall.position.x = -1 * CGFloat((355 / halfMaze) * (i % mazeSize))
            }
            if(i/mazeSize > halfMaze){ //if positive on y
                wall.position.y = CGFloat((500 / halfMaze) * ((i / mazeSize) / 2))
            }
            else if(i/mazeSize == 0){ //if middle of x(0), only for odd# sizes
                wall.position.y = 0
            }
            else{ //if negative on y
                wall.position.y = -CGFloat((500 / halfMaze) * (((i / mazeSize) / 2) + 1))
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
        //sets delIndex to clear so only newly deleted indexes will be affected.
        delIndexes = []
        //makes 5*5 maze all set to true
        var TwoDmaze = [Array](repeating: [Bool](repeating: true, count: mazeSize), count: mazeSize)
        var win = false
        var column = Int.random(in: 0...mazeSize - 1) // starts from random selection in bottom
        var row = 0 //row 1 is the "bottom" because of how I developed my maze in actual maze
        //deletes certain walls to allow player through maze
        while(!win){
            //deleted wall selected
            TwoDmaze[row][column] = false
            if(row == mazeSize - 1){ // if top row
                win = true
            } else { //if not top row (end)
                if(column != 0 && column != mazeSize - 1){ //if not on sides of maze
                    let delWall = Int.random(in: 1...3)
                    if(delWall == 1){
                        row += 1
                    }
                    else if(delWall == 2){
                        column += 1
                    }
                    else{
                        column += -1
                    }
                } else if(column != 0){ //if on right side of maze
                    let delWall = Int.random(in: 1...2)
                    if(delWall == 1){
                        row += 1
                    } else {
                        column += -1
                    }
                }
                else{ //if on left side of maze
                    let delWall = Int.random(in: 1...2)
                    if(delWall == 1){
                        row += 1
                    } else {
                        column += 1
                    }
                }
            }
        }
        //sets value set in 2dmaze in place
        var i = 0
        var j = 0
        var a = 0
        while(i < mazeSize){
            j = 0
            while(j < mazeSize){
                //conversion from TwoDMaze(2d array) to maze(1d array)
                var location = 0
                if(a >= (mazeSize * 2)){
                    location = a
                }
                else if(a < mazeSize){ //row 0 in maze, row 1 in 2d
                    location = j + mazeSize
                }
                else{ //row 1 in maze, row 0 in 2d
                    location = j
                }
                if(!TwoDmaze[i][j]){ //if not supposed to exist
                    maze[location]!.isHidden = true
                    delIndexes.append(location)
                } else {
                    maze[location]!.isHidden = false
                }
                a += 1
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
        for index in delIndexes{
            maze[index]!.physicsBody = nil
        }
    }
}
