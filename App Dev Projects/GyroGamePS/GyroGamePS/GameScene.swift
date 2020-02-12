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
    private var scoreLbl : SKLabelNode?
    private var player: SKSpriteNode?
    //MARK: functions
    override func didMove(to view: SKView) {
        //Sets up nodes
        self.scoreLbl = self.childNode(withName: "scoreLbl") as? SKLabelNode
        self.player = self.childNode(withName: "playerSprite") as? SKSpriteNode
        setupPlayer()
        //Sets up other stuff
        setupGyro()
        moveObject(x: 0)
    }
    //MARK: setup/generation functions
    //Sets up player node
    func setupPlayer(){
        player?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 25, height: 25))
        player?.physicsBody?.isDynamic = true
        player?.physicsBody?.affectedByGravity = true
        player?.physicsBody?.allowsRotation = false
        player?.physicsBody?.angularDamping = 0
        player?.physicsBody?.linearDamping = 0
        player?.physicsBody?.friction = 0
        player?.physicsBody?.restitution = 0
        player?.physicsBody?.mass = 1
        player?.zRotation = 0
        player?.zPosition = 1
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
    //Makes a wall with one piece missing
    func generateWall(){
        
    }
    //MARK: physics functions
    //Moves the object
    func moveObject(x: Double){
        player?.physicsBody?.velocity = CGVector(dx: x, dy: Double((player?.physicsBody?.velocity.dy)!))
        print("X: \(x)")
    }
    //MARK: update function
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
