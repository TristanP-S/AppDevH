//
//  TitleScene.swift
//  PongPS
//
//  Created by Tristan Pudell-Spatscheck on 11/18/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import Foundation
import GameplayKit
class TitleScene:SKScene{
    //starts game when screen is tapped
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scene = SKScene(fileNamed: "GameScene") 
        // Set the scale mode to scale to fit the window
        scene!.scaleMode = .aspectFill
        // Present the scene
        view!.presentScene(scene)
        }
}
