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
//MARK - Global Variables
var rolling = false //wether ball is currently rolling
var gameVC = GameViewController()
class GameViewController: UIViewController {
    //MARK - Variables
    //music Player
    var musicPlayer : AVAudioPlayer = AVAudioPlayer()
    var panRec : UIPanGestureRecognizer!
    var lastSwipeBeginningPoint: CGPoint?
    //MARK - Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        gameVC = self
        //defines + adds swipes to VC
        panRec = UIPanGestureRecognizer(target: self, action: #selector(gameVC.handlePan(recognizer:)))
        self.view.addGestureRecognizer(panRec)
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
    //handles each swipe
    @objc func handlePan(recognizer: UISwipeGestureRecognizer) {
    if recognizer.state == .began {
        lastSwipeBeginningPoint = recognizer.location(in: recognizer.view)
    } else if recognizer.state == .ended {
        guard let startPt = lastSwipeBeginningPoint else { //start of swipe
            return
        }
        let endPt = recognizer.location(in: recognizer.view) //end of swipe
        // TODO: use the x and y coordinates of endPoint and beginPoint to determine which direction the swipe occurred.
        let changePt = CGPoint(x: endPt.x - startPt.x, y: startPt.y - endPt.y)
        gameSC.moveBall(change: changePt)
    }
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
