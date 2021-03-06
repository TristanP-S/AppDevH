//
//  GameViewController.swift
//  GameDevPS
//
//  Created by Tristan Pudell-Spatscheck on 12/16/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
// The ViewController (used for buttons + navigation)
import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
var gameVC = GameViewController()
class GameViewController: UIViewController {
    //MARK - Outlets
    @IBOutlet weak var gameView: SKView!
    @IBOutlet weak var shopBtn: UIButton!
    @IBOutlet weak var minigameBtn: UIButton!
    //MARK - Variables
    var musicPlayer : AVAudioPlayer = AVAudioPlayer()
    //MARK - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        gameVC = self
        //loads music
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSession.Category.playback)
        } catch {
            print("NO SESSION")
        }
        //playSong(song: "No Song")
        if let view = self.gameView {
            // Load the SKScene from 'MainScene.sks'
            if let scene = SKScene(fileNamed: "MainScene") {
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
    //makes a basic alert with an ok button and presents it
    func makeAlert(scene: SKScene, message: String){
        let alertMessage = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default) { action in
            //call any needed functions here
            print("OK pressed")
        }
        alertMessage.addAction(okayAction)
        gameVC.present(alertMessage, animated: true)
    }
    //shop button pressed
    @IBAction func shopPressed(_ sender: Any) {
    }
    //minigame button pressed (presents minigame VC)
    @IBAction func minigamePressed(_ sender: Any) {
        //presents mingame scene
        if let view = self.gameView {
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
        shopBtn.isHidden = true
        minigameBtn.isHidden = true
    }
    //MARK - Default Functions
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
