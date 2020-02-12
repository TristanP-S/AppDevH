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
        //Sets up other stuff
        setupGyro()
        moveObject(x: 0, y: 0)
    }
    //MARK: setup functions
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
                self.moveObject(x: x, y: y)
            }
        }
    }
    //Moves the object
    func moveObject(x: Double, y: Double){
        print("X: \(x), Y: \(y)")
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
