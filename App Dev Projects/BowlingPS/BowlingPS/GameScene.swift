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
var gameSC = GameScene()
var time: Double = 0
var difficulty = 0 // 0: easy mode (kid walls), 1: hard mode (gutters)
class GameScene: SKScene {
    //MARK - Variables
    var td: Bool = false
    var pos5: Bool = false
    var animateBall = false
    var ball = SKSpriteNode()
    var locations: [CGPoint] = []
    var pins = [SKSpriteNode](repeating: SKSpriteNode(), count: 10)
    var gutterWall1 = SKSpriteNode()
    var gutterWall2 = SKSpriteNode()
    let ballCategory: UInt32 = 0x1 << 1
    let pinCategory: UInt32 = 0x1 << 2
    let gutterCategory: UInt32 = 0x1 << 3
    let wallCategory: UInt32 = 0x1 << 4
    override func didMove(to view: SKView) {
        gameSC = self
        //sets up sprite physics
        ball = self.childNode(withName: "bowlingBall") as! SKSpriteNode
        setBall()
        for i in 0...9{ //sets up pins
            pins[i] = self.childNode(withName: "pin\(i+1)") as! SKSpriteNode
            pins[i].name = "pin\(i)"
            pins[i].physicsBody?.categoryBitMask = pinCategory
            pins[i].physicsBody?.collisionBitMask = ballCategory
        }
        //sets up border of screen as border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1 //makes ball bounce off walls
        border.isDynamic = false
        self.physicsBody = border
        //sets up guttons/kid walls
        gutterWall1 = self.childNode(withName: "gutterWall1") as! SKSpriteNode
        gutterWall2 = self.childNode(withName: "gutterWall2") as! SKSpriteNode
        setBorders(wall: gutterWall1, positive: false)
        setBorders(wall: gutterWall2, positive: true)
        //sets up pins
        resetPins()
    }
    //moves ball in a direction
    func moveBall(change: CGPoint){
        var rChange: CGPoint = change
        if(!rolling){
            if(change.y <= 0 || (change == CGPoint(x: 0, y: 0))){
                gameVC.makeAlert(message: "You need to fling the ball FORWARD")
            }
            else{
            print("Force multiplyers; x: \(change.x) , y: \(change.y)")
            if(change.y > 250){ //makes sure ball isn't too fast
                rChange.y = 200
            }
            //moves ball based on change and tells game it is "rollling"
            ball.physicsBody?.applyForce(CGVector(dx: CGFloat(0 + (5000 * (rChange.x))), dy: CGFloat(0 + (5000  * (rChange.y)))))
            rolling = true
            animateBall = true
            }
        }
    }
    //collision detection for gutters (uses zPos to set ball to firstBody)
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if ((firstBody.categoryBitMask & ballCategory) != 0 &&
            (secondBody.categoryBitMask & gutterCategory != 0)) {
                print ("Contact detected")
        }
    }
    func setBall(){ //sets up ball's physics body
        ball.texture = SKTexture(imageNamed: "bowlingBall")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        ball.physicsBody?.mass = 20
        disableDefaults(sprite: ball)
        ball.physicsBody?.restitution = 1 // makes ball bounce off walls
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = gutterCategory
        ball.physicsBody?.collisionBitMask = wallCategory | pinCategory
        ball.zPosition = 2
        rolling = false
        animateBall = false
    }
    //ball rolls to gutter to get back to start
    func resetBall(){
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        var moveToTop = SKAction()
        var moveToBottom = SKAction()
        if(ball.position.x > 0){ //goes right if ball on right
            moveToTop = SKAction.move(to: CGPoint(x: 300, y: 550), duration: 3)
            moveToBottom = SKAction.move(to: CGPoint(x: 300, y: -550), duration: 3)
        }
        else{ //goes left if ball on left
            moveToTop = SKAction.move(to: CGPoint(x: -300, y: 550), duration: 3)
            moveToBottom = SKAction.move(to: CGPoint(x: -300, y: -550), duration: 3)
        }
        let moveToStart = SKAction.move(to: CGPoint(x: 0, y: -535), duration: 3)
        ball.physicsBody = nil
        let resetBall = SKAction.sequence([moveToTop, moveToBottom, moveToStart])
        ball.run(resetBall) //moves ball back to start
    }
    //helps set up borders based on settings
    func setBorders(wall: SKSpriteNode, positive: Bool){
        //sets up gutters / kid walls
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 1340))
        wall.size = CGSize(width: 50, height: 1334)
        if(positive){
            wall.position.x = 350
        }
        else{
            wall.position.x = -350
        }
        wall.position.y = 0
        wall.zPosition = 1
        disableDefaults(sprite: wall)
        wall.physicsBody?.isDynamic = false
        if(difficulty == 0){ //kid walls / easy mode
            wall.color = UIColor(ciColor: .white)
            wall.physicsBody?.restitution = 1
            wall.physicsBody?.categoryBitMask = wallCategory
            wall.physicsBody?.collisionBitMask = wallCategory
        }
        else{
            wall.color = UIColor(ciColor: .red)
            wall.physicsBody?.restitution = 0
            wall.physicsBody?.categoryBitMask = gutterCategory
            wall.physicsBody?.contactTestBitMask = ballCategory //only needed for gutters
        }
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
    //deletes (hides) the pins so they can be reset
    func delPins(){ //deletes pins
        for pin in pins{
            pin.isHidden = true
            pin.physicsBody = nil
        }
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
    //"ends" round, resets balls to their original position
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
        //sets everything back to initial values
        resetBall()
        locations = []
        rolling = false
        resetPins()
        time = 0
        points = 10
    }
    override func update(_ currentTime: TimeInterval) { //asumed to run 60 FPS
        // Called before each frame is rendered
        if(rolling){ //if ball is at end, time is a failsafe if pins are weird
            time += 1/60
            //checks the boolean values
            pos5 = ball.position.y > 500
            if(!pos5){ //short circuit
                if(difficulty == 0){
                    td = time > 10
                }
                else{
                    td = time > 5
                }
            }
            if(pos5 || td){ //ball end condition based on difficulty
                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                td = false
                pos5 = false
                gameEnd()
            }
        }
        if(ball.position == CGPoint(x: 0, y: -535) && rolling){ //gives the ball its physics again after being reset
            setBall()
        }
    }
}
