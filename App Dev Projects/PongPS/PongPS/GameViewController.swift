//
//  GameViewController.swift
//  PongPS
//
//  Created by Tristan Pudell-Spatscheck on 11/18/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
//DEV NOTES: Expert AI has been proven POSSIBLE TO BEAT. It's just very hard. Also, if there is NO music, it either means your iOS is under 13.2 (which this was built for), OR you need to go to the .mp3 files in this project and change their "location" to the music folder in the PongPS file
import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
//MARK: global variables
var gamemode = 1
var gameVC: GameViewController = GameViewController()
class GameViewController: UIViewController {
    //MARK: variables
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var normalBtn: UIButton!
    @IBOutlet weak var expertBtn: UIButton!
    @IBOutlet weak var multiplayerBtn: UIButton!
    @IBOutlet weak var optionsBtn: UIButton!
    @IBOutlet weak var achievmentBtn: UIButton!
    var gameMusic: AVAudioPlayer = AVAudioPlayer()
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets up stored/persistant values
        if(UserDefaults.standard.bool(forKey: "god") != nil){ //checks if app was loaded before
            god = UserDefaults.standard.bool(forKey: "god")
            eGod = UserDefaults.standard.bool(forKey: "eGod")
            music = UserDefaults.standard.bool(forKey: "music")
            easyDubs = UserDefaults.standard.bool(forKey: "easyDubs")
            goodPlayer = UserDefaults.standard.bool(forKey: "goodPlayer")
            godGamer = UserDefaults.standard.bool(forKey: "godGamer")
            breadWinner = UserDefaults.standard.integer(forKey: "breadWinner")
        } else {
            UserDefaults.standard.set(god, forKey: "god")
            UserDefaults.standard.set(eGod, forKey: "eGod")
            UserDefaults.standard.set(music, forKey: "music")
            UserDefaults.standard.set(easyDubs, forKey: "easyDubs")
            UserDefaults.standard.set(goodPlayer, forKey: "goodPlayer")
            UserDefaults.standard.set(godGamer, forKey: "godGamer")
            UserDefaults.standard.set(breadWinner, forKey: "breadWinner")
        }
        //plays background music infinitely
        let session = AVAudioSession.sharedInstance()
        do{
            try session.setCategory(AVAudioSession.Category.playback)
        } catch {
            print("NO SESSION")
        }
        playSong(song: "PBRSunnyPark")
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
    //MARK: functions
    //sets song to title given
    func playSong(song: String){
        gameMusic.stop()
        if(music){
            do{
                let song1 = Bundle.main.path(forResource: song, ofType: "mp3")
                try gameMusic = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: song1!) as URL)
            } catch {
                print("NO SONG FILE for \(song)")
            }
            gameMusic.numberOfLoops = -1
            gameMusic.play()
        }
    }
    //enables/disables the buttons
    func btnEnable(off: Bool){
        easyBtn?.isHidden = off
        normalBtn?.isHidden = off
        expertBtn?.isHidden = off
        multiplayerBtn?.isHidden = off
        optionsBtn?.isHidden = off
        achievmentBtn?.isHidden = off
    }
    func startGame(){
        btnEnable(off: true)
        //changes song to battle tower music
        playSong(song: "SWSHBattleTower")
        //sets up gameVC to current VC
        gameVC = self
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
        playSong(song: "PBRSunnyPark")
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
    @IBAction func optionsPressed(_ sender: Any) {
        gameMusic.stop()
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
