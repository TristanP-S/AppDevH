//
//  GameViewController.swift
//  BowlingPS
//
//  Created by Tristan Pudell-Spatscheck on 12/9/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
//NOTE: Ball going straight forward may make pins + ball not move, but there's a timeout for problems like that, Ball takes 2 swipes after the first throw to work properly (no fix atm)
import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import AVKit
//MARK - Global Variables
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
            let changePt = CGPoint(x: endPt.x - startPt.x, y: startPt.y - endPt.y)
            gameSC.moveBall(change: changePt)
        }
    }
    //makes a basic alert with an ok button and presents it
    func makeAlert(message: String){
        let alertMessage = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { action in
            //call any needed functions here
            print("OK pressed")
            time = 0
        }
        alertMessage.addAction(okayAction)
        gameVC.present(alertMessage, animated: true)
    }
    //plays a video with the given name
    func playVid(vidName: String){
        if let path = Bundle.main.path(forResource: vidName, ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            present(videoPlayer, animated: true, completion:{
                video.play()
            })
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
