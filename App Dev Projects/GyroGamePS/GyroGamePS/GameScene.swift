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
    //MARK: functions
    override func didMove(to view: SKView) {
        //Sets up nodes
        self.scoreLbl = self.childNode(withName: "scoreLbl") as? SKLabelNode
        //Sets up other stuff
        setupGyro()
    }
    //MARK: setup functions
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
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
