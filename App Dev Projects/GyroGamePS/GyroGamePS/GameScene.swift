//
//  GameScene.swift
//  GyroGamePS
//
//  Created by Tristan Pudell-Spatscheck on 2/11/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //MARK: variables
    private var scoreLbl : SKLabelNode?
    //MARK: functions
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        self.scoreLbl = self.childNode(withName: "scoreLbl") as? SKLabelNode
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
