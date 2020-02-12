//
//  GameScene.swift
//  GyroGamePS
//
//  Created by Tristan Pudell-Spatscheck on 2/11/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//
import SpriteKit
import GameplayKit
import CoreMotion
class GameScene: SKScene {
    //MARK: variables
    var motionManager : CMMotionManager = CMMotionManager()
    private var spawnedWalls: [[SKSpriteNode]] = []
    private var scoreLbl : SKLabelNode?
    private var player: SKSpriteNode?
    //MARK: functions
    override func didMove(to view: SKView) {
        //Sets up nodes
        self.scoreLbl = self.childNode(withName: "scoreLbl") as? SKLabelNode
        self.player = self.childNode(withName: "playerSprite") as? SKSpriteNode
        setupPlayer()
        //Sets up other stuff
        setupBorder()
        setupGyro()
        moveObject(x: 0)
        nextWall()
    }
    //MARK: setup/generation functions
    //Sets up player node
    func setupPlayer(){
        player?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        player?.size = CGSize(width: 50, height: 50)
        player?.position = CGPoint(x: 500, y: 0)
        setDefaults(sprite: player!, mass: 1, zPosition: 2, affectedByGravity: true, isDyamic: true)
    }
    //Makes a wall
    func generateWall(width: CGFloat, height: CGFloat, position: CGPoint) -> SKSpriteNode{
        let wall = SKSpriteNode(color: .red, size: CGSize(width: width, height: height))
        wall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        wall.position = position
        setDefaults(sprite: wall, mass: 1000, zPosition: 1, affectedByGravity: false, isDyamic: true)
        wall.physicsBody?.velocity = CGVector(dx: 0, dy: 100)
        return wall
    }
    //Makes a entire wall with one piece missing
    func nextWall(){
        let width: CGFloat = 100
        let height: CGFloat = 50
        let wall1: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: 0, y: -100))
        let wall2: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: -(width * 1.25), y: -100))
        let wall3: SKSpriteNode = generateWall(width: width, height: height, position: CGPoint(x: (width * 1.25), y: -100))
        var fullWall: [SKSpriteNode] = [wall1, wall2, wall3]
        fullWall.remove(at: Int.random(in: 0...fullWall.count - 1)) //removes a random wall
        for wall in fullWall{ //adds wall to scene
            self.addChild(wall)
        }
        spawnedWalls.append(fullWall)
    }
    //Sets up border of screen as its own physics body
    func setupBorder(){
        //sets up border of screen as border
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0
        border.isDynamic = false
        self.physicsBody = border
    }
    //Sets up gyroscope sensor data
    func setupGyro(){
        motionManager.gyroUpdateInterval = 0.2
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            print(data as Any)
            if let trueData = data {
                let x = trueData.rotationRate.x
                let y = trueData.rotationRate.y
                let z = trueData.rotationRate.z
                //do motion here
                print("X: \(x), Y: \(y), Z: \(z)")
                self.moveObject(x: x)
            }
        }
    }
    //MARK: physics functions
    //Moves the object
    func moveObject(x: Double){
        player?.physicsBody?.velocity = CGVector(dx: x, dy: Double((player?.physicsBody?.velocity.dy)!))
        print("X: \(x)")
    }
    //MARK: useful/shortcut functions
    func setDefaults(sprite: SKSpriteNode, mass : CGFloat, zPosition: CGFloat, affectedByGravity: Bool, isDyamic: Bool){
        sprite.physicsBody?.affectedByGravity = affectedByGravity
        sprite.physicsBody?.isDynamic = isDyamic
        sprite.physicsBody?.allowsRotation = false
        sprite.physicsBody?.angularDamping = 0
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.friction = 0
        sprite.physicsBody?.restitution = 0
        sprite.physicsBody?.mass = mass
        sprite.zRotation = 0
        sprite.zPosition = zPosition
    }
    //MARK: update function
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(spawnedWalls.count > 0 && spawnedWalls[0][0].position.y > 200){ //removes wall when it hits a certain point near the top
            spawnedWalls.removeFirst()
        }
    }
}
