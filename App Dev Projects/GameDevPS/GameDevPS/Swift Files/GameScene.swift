//
//  GameScene.swift
//  GameDevPS
//
//  Created by Tristan Pudell-Spatscheck on 12/18/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
//  The first minigame scene
import UIKit
import SpriteKit
import GameplayKit
//MARK - Global Variables
var gameSC: SKScene = SKScene()
class GameScene: SKScene {
    //MARK - Variables
    //MARK - Functions
    //Viewdid load
    override func didMove(to view: SKView) {
        gameSC = self
    }
    //Update function
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
