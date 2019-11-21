//
//  GameViewController.swift
//  PongPS
//
//  Created by Tristan Pudell-Spatscheck on 11/18/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
//DEV NOTES: Expert AI has been proven POSSIBLE TO BEAT. It's just very hard. 
import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
var gamemode = 1
class GameViewController: UIViewController {
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var normalBtn: UIButton!
    @IBOutlet weak var expertBtn: UIButton!
    @IBOutlet weak var multiplayerBtn: UIButton!
    var gameMusic: AVAudioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        //plays background music infinitely
        do{
            let song1 = Bundle.main.path(forResource: "PBRSunnyPark", ofType: "mp3")
            try gameMusic = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: song1!) as URL)
        } catch {
            print("NO SONG FILE")
        }
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSession.Category.playback)
        } catch {
            print("NO SESSION")
        }
        gameMusic.numberOfLoops = -1
        gameMusic.play()
        //enables buttons
        btnEnable(off: false)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'TitleScene.sks'
            if let scene = SKScene(fileNamed: "TitleScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
        }
    }
    //enables/disables the buttons
    func btnEnable(off: Bool){
        easyBtn?.isHidden = off
        normalBtn?.isHidden = off
        expertBtn?.isHidden = off
        multiplayerBtn?.isHidden = off
    }
    func startGame(){
        btnEnable(off: true)
        //changes song to battle tower music
        gameMusic.stop()
        do{
            let song1 = Bundle.main.path(forResource: "SWSHBattleTower", ofType: "mp3")
            try gameMusic = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: song1!) as URL)
        } catch {
            print("NO SONG FILE")
        }
        gameMusic.play()
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
    func restartGame(){
        btnEnable(off: false)
        gameMusic.stop()
        do{
            let song1 = Bundle.main.path(forResource: "PBRSunnyPark", ofType: "mp3")
            try gameMusic = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: song1!) as URL)
        } catch {
            print("NO SONG FILE")
        }
        gameMusic.play()
    }
    //all the gamemode selecting options
    @IBAction func easyPressed(_ sender: Any) {
        gamemode = 1
        startGame()
    }
    @IBAction func normalPressed(_ sender: Any) {
        gamemode = 2
        startGame()
    }
    @IBAction func expertPressed(_ sender: Any) {
        gamemode = 3
        startGame()
    }
    @IBAction func multiplayerPressed(_ sender: Any) {
        gamemode = 4
        startGame()
    }
    //default spritekit stuff
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
