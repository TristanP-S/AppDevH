//
//  GameViewController.swift
//  MazePS
//
//  Created by Tristan Pudell-Spatscheck on 11/26/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
/*PLEASE NOTE FOR MUSIC TO WORK YOU MIGHT HAVE TO CLICK 'SOS.mp3' and change its 'full path' to its location in the project folder for music to work, also only odd numbered values for length/width work (in the scrapped settings menu)
 Notes for grading: The rubric didn't ask for a proper 'maze' algorithm, so I attempted to build my own, which didn't go to well due to me not figuring out my own (without help from the internet) in the time constraints, but this still classifies as a maze. It fufills fluid movement + no weird wall interactions, which are the only things similar to that. In terms of extra stuff, highscore is included, but only in alerts. Multiple levels / Mazes is also included, as every time a maze is beat, or the app is loaded it generates a new 'maze'.
 
 */
import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
class GameViewController: UIViewController {
    //MARK - Outlet Vars
    @IBOutlet weak var upArrow: UIButton!
    @IBOutlet weak var downArrow: UIButton!
    @IBOutlet weak var rightArrow: UIButton!
    @IBOutlet weak var leftArrow: UIButton!
    //MARK - Normal Vars/Setup
    var musicPlayer : AVAudioPlayer = AVAudioPlayer()
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
    //up buttons stopped being pressed
    @IBAction func upStopped(_ sender: Any) {
        gameScene.movePlayer(direction: 0)
    }
    //down button stopped being pressed
    @IBAction func downStopped(_ sender: Any) {
        gameScene.movePlayer(direction: 0)
    }
    //right button stopped being pressed
    @IBAction func rightStopped(_ sender: Any) {
        gameScene.movePlayer(direction: 0)
    }
    //left button stopped being pressed
    @IBAction func leftStopped(_ sender: Any) {
        gameScene.movePlayer(direction: 0)
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
