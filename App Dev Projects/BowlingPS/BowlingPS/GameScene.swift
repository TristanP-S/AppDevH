//
//  GameScene.swift
//  BowlingPS
//
//  Created by Tristan Pudell-Spatscheck on 12/9/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
import SpriteKit
import GameplayKit
//MARK - Global Variables
var rolling = false //wether ball is currently rolling
var points: Int = 10
var pins = [SKSpriteNode](repeating: SKSpriteNode(), count: 10)
var gameSC = GameScene()
var time: Double = 0
class GameScene: SKScene {
    //MARK - Variables
    var ball = SKSpriteNode()
    var locations: [CGPoint] = []
    override func didMove(to view: SKView) {
        gameSC = self
        //sets up sprite physics
        ball = self.childNode(withName: "bowlingBall") as! SKSpriteNode
        ball.texture = SKTexture(imageNamed: "bowlingBall")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        ball.physicsBody?.mass = 5
        disableDefaults(sprite: ball)
        ball.physicsBody?.restitution = 1 // makes ball bounce off walls
        for i in 0...9{ //sets up pins
            pins[i] = self.childNode(withName: "pin\(i+1)") as! SKSpriteNode
            pins[i].name = "pin\(i)"
        }
        //sets up border of screen as border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1 //makes ball bounce off walls
        border.isDynamic = false
        self.physicsBody = border
        //sets up pins
        resetPins()
    }
    //resets pins to original spots + sizes
    func resetPins(){
        pinSetup(pin: pins[0], xPos: 0, yPos: 0)
        pinSetup(pin: pins[1], xPos: -100, yPos: 160)
        pinSetup(pin: pins[2], xPos: 100, yPos: 160)
        pinSetup(pin: pins[3], xPos: -200, yPos: 300)
        pinSetup(pin: pins[4], xPos: 0, yPos: 300)
        pinSetup(pin: pins[5], xPos: 200, yPos: 300)
        pinSetup(pin: pins[6], xPos: -280, yPos: 450)
        pinSetup(pin: pins[7], xPos: -100, yPos: 450)
        pinSetup(pin: pins[8], xPos: 100, yPos: 450)
        pinSetup(pin: pins[9], xPos: 280, yPos: 450)
    }
    //ball rolls to gutter to get back to start
    func resetBall(){
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let moveToTop = SKAction.move(to: CGPoint(x: 0, y: 500), duration: 3)
        let moveToBottom = SKAction.move(to: CGPoint(x: 0, y: -500), duration: 3)
        let moveToStart = SKAction.move(to: CGPoint(x: 0, y: -535), duration: 3)
        print("up")
        ball.run(moveToTop)
        print("down")
        ball.run(moveToBottom)
        print("start")
        ball.run(moveToStart)
        rolling = false
    }
    func delPins(){ //deletes pins
        for pin in pins{
            pin.isHidden = true
            pin.physicsBody = nil
        }
    }
    //used to make resetPins concise (actual setup per pin)
    func pinSetup(pin: SKSpriteNode, xPos: CGFloat, yPos: CGFloat){
        pin.position.x = xPos
        pin.position.y = yPos
        pin.size.width = 50
        pin.size.height = 100
        pin.zRotation = 0
        pin.texture = SKTexture(imageNamed: "bowlingPin")
        pin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 100))
        pin.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        pin.physicsBody?.mass = 1
        disableDefaults(sprite: pin)
        locations.append(pin.position)
    }
    //disables some default physics stuff that isn't needed
    func disableDefaults(sprite: SKSpriteNode){
        sprite.isHidden = false
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.allowsRotation = true
        sprite.physicsBody?.isDynamic = true
        sprite.physicsBody?.restitution = 0
        sprite.physicsBody?.friction = 0
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
    }
    //moves ball in a direction
    func moveBall(change: CGPoint){
        if(!rolling && change != CGPoint(x: 0, y: 0)){
        print("x: \(change.x)")
        print("y: \(change.y)")
        //moves ball based on change and tells game it is "rollling"
        ball.physicsBody?.applyForce(CGVector(dx: CGFloat(0 + (500 * (change.x))), dy: CGFloat(0 + (500 * (change.y)))))
        rolling = true
        }
    }    //"ends" round, resets balls to their original position
    func gameEnd(){
        //checks position vs. location to check the pins knocked down, then resets them
        for n in 0...9{
            //sets to Ints to correct the doubles being .000000001 off, also affects if statement
            let intPins = CGPoint(x: Int(pins[n].position.x), y: Int(pins[n].position.y))
            var locX: Int = 0 //default if x/y is 0
            var locY: Int = 0 //default if x/y is 0
            if(locations[n].x > 0){
                locX = Int(locations[n].x - 1)
            }
            else if(locations[n].x < 0){
                locX = Int(locations[n].x + 1)
            }
            if(locations[n].y > 0){
                locY = Int(locations[n].y - 1)
            }
            else if(locations[n].y < 0){
                locY = Int(locations[n].y + 1)
            }
            if((intPins == CGPoint(x: locX, y: locY)) || (intPins == CGPoint(x: CGFloat(locX), y: locations[n].y)) || (intPins == CGPoint(x: locations[n].x, y: CGFloat(locY))) || (intPins == locations[n])){
                points += -1
            }
        }
        gameVC.makeAlert(message: "You knocked down \(points) pins!")
        delPins()
        //resetBall() <- Broken, code below is a temp solution
        ball.position.x = 0
        ball.position.y = -535
        //resets vlues to initial
        locations = []
        resetPins()
        rolling = false
        time = 0
        points = 10
    }
    override func update(_ currentTime: TimeInterval) { //asumed to run 60 FPS
        // Called before each frame is rendered
        if(rolling){ //if ball is at end, time is a failsafe if pins are weird
            time += 1/60
            if(ball.position.y > 500 || time > 5){
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                gameEnd()
            }
        }
    }
}
