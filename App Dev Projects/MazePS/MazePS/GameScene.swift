//
//  GameScene.swift
//  MazePS
//
//  Created by Tristan Pudell-Spatscheck on 11/26/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var mazeImg = SKSpriteNode()
    var ball = SKSpriteNode()
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        mazeImg = self.childNode(withName: "mazeBckg") as! SKSpriteNode
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
