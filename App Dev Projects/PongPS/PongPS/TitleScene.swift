//
//  TitleScene.swift
//  PongPS
//
//  Created by Tristan Pudell-Spatscheck on 11/18/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import Foundation
import GameplayKit
var score1 = 0 //player score
var score2 = 0 //enemy score
class TitleScene:SKScene{
    var scoreText = SKLabelNode()
    //Game ending text, set to blank if no game was played
    override func didMove(to view: SKView) {
        scoreText = self.childNode(withName: "resultLbl") as! SKLabelNode
        if(score1 == 9){
            if(gamemode != 4){ //short circuits for non-multiplayer
                scoreText.text = "Congrats, You won 10 to \(score2)!"
            } else {
                scoreText.text = "Green won 10 to \(score2)!"
            }
        } else if(score2 == 9){
            if(gamemode != 4){
                scoreText.text = "Darn, You lost 10 to \(score1)!"
            } else {
                scoreText.text = "Red won 10 to \(score1)!"
            }
        } else {
            scoreText.text = ""
        }
    }
}
