//
//  GameViewController.swift
//  MazePS
//
//  Created by Tristan Pudell-Spatscheck on 11/26/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
//PLEASE NOTE FOR MUSIC TO WORK YOU MIGHT HAVE TO CLICK 'SOS.mp3' and change its 'full path' to its location in the project folder for music to work
import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
class GameViewController: UIViewController {
    @IBOutlet weak var upArrow: UIButton!
    @IBOutlet weak var downArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var leftArrow: UIButton!
    var musicPlayer : AVAudioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        //loads music
        let session = AVAudioSession.sharedInstance()
               do{
                   try session.setCategory(AVAudioSession.Category.playback)
               } catch {
                   print("NO SESSION")
               }
        playSong(song: "SOS")
        //loads game scene
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
    //normal functions
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
    //up button pressed
    @IBAction func upPressed(_ sender: Any) {
        gameScene.movePlayer(direction: 1)
    }
    //down button pressed
    @IBAction func downPressed(_ sender: Any) {
        gameScene.movePlayer(direction: 2)
    }
    //right button pressed
    @IBAction func rightPressed(_ sender: Any) {
        gameScene.movePlayer(direction: 3)
    }
    //left button pressed
    @IBAction func leftPressed(_ sender: Any) {
        gameScene.movePlayer(direction: 4)
    }
    //default functions
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
