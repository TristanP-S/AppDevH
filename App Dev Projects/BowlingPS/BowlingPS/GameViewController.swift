//
//  GameViewController.swift
//  BowlingPS
//
//  Created by Tristan Pudell-Spatscheck on 12/9/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    //MARK - Variables
    //music Player
    var musicPlayer : AVAudioPlayer = AVAudioPlayer()
    //MARK - Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Loads scene
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    //MARK - Normal Functions
    //sets song to title given
    func playSong(song: String){
        musicPlayer.stop()
            do{
                let song1 = Bundle.main.path(forResource: song, ofType: "mp3")
                try musicPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: song1!) as URL)
            } catch {
                print("NO SONG FILE for \(song)")
            }
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
    }
    //MARK - Default
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
