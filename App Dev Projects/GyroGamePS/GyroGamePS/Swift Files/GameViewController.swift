//
//  GameViewController.swift
//  GyroGamePS
//
//  Created by Tristan Pudell-Spatscheck on 2/11/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
//global var
var gameVC: GameViewController = GameViewController()
class GameViewController: UIViewController {
    //variables
    var musicPlayer : AVAudioPlayer = AVAudioPlayer()
    //sets up gamescene
    override func viewDidLoad() {
        gameVC = self
        super.viewDidLoad()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
        }
    }
    //plays a given song on repeat
    func playSong(song: String){
        musicPlayer.stop()
            do{
                let song1 = Bundle.main.path(forResource: song, ofType: "wav")
                try musicPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: song1!) as URL)
            } catch {
                print("NO SONG FILE for \(song)")
            }
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
    }
    //makes it so screen doesn't rotate
    override var shouldAutorotate: Bool {
        return false
    }
    //makes it so screen is always in portait
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }
    //idk what this is, but it was here by default
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
