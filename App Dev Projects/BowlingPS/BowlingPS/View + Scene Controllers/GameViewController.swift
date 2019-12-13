//
//  GameViewController.swift
//  BowlingPS
//
//  Created by Tristan Pudell-Spatscheck on 12/9/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
/* NOTES/BUGS
 -Ball  may make pins + ball keep floating and not end the game, but there's a timeout for problems like that
 -Ball takes 2 swipes after the first throw to work properly (no fix atm)
 -ONLY tested on iPhone 8 emulator and real iPhone 7, might have issues on others
 -I gave up on animating the ball, but the remenants are still there
 */
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
    @IBOutlet weak var diffButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!
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
            videoPlayer.player?.isMuted = true
            videoPlayer.showsPlaybackControls = false
            NotificationCenter.default.addObserver(self, selector: #selector(vidDone), name: .AVPlayerItemDidPlayToEndTime, object: nil)
            present(videoPlayer, animated: true, completion:{
                video.play()
            })
        }
    }
    //closes video when finished playing
    @objc func vidDone(){
        dismiss(animated: true, completion: nil)
        if(backShot){
            gameVC.makeAlert(message: "You need to fling the ball FORWARD")
            backShot = false
        }
        if(gameOver){
            gameSC.takeResults()
            gameOver = false
        }
    }
    //difficulty changed
    @IBAction func changeDiff(_ sender: Any) {
        if(difficulty == 0){
            difficulty = 1
            diffButton.setTitle("Difficulty: Normal", for: .normal)
        }
        else{
            difficulty = 0
            diffButton.setTitle("Difficulty: Child", for: .normal)
        }
        totalPoints = 0
        points = 10
        time = 0
        rolling = false
        gameSC.spare = false
        gameSC.locations = []
        scorePos = 0
        rScorePos = 0
        gameSC.setupScores()
        gameSC.setBall()
        gameSC.setBorders(wall: gameSC.gutterWall1, positive: true)
        gameSC.setBorders(wall: gameSC.gutterWall2, positive: false)
        gameSC.delPins()
        gameSC.resetPins()
        gameSC.resetBall()
        gameSC.hiddenPins = [SKSpriteNode?](repeating: nil, count: 10)
    }
    //toggles music
    @IBAction func musicToggled(_ sender: Any) {
        if(musicButton.titleLabel!.text == "Music: Off"){
            playSong(song: "wiiBowl")
            musicButton.setTitle("Music: On", for: .normal)
        }
        else{
            musicPlayer.stop()
            musicButton.setTitle("Music: Off", for: .normal)
        }
    }
    //toggles animations
    @IBAction func animationToggle(_ sender: Any) {
        if(animationButton.titleLabel!.text == "| Animations: On |"){
            animations = false
            animationButton.setTitle("| Animations: Off |", for: .normal)
        }
        else{
            animations = true
            animationButton.setTitle("| Animations: On |", for: .normal)
        }
    }
    //shares image
    func shareImg(image: UIImage){
        // set up activity view controller
        let imageToShare = [ image ] //converts image to "Any"
        //sets up VC so it works for all devices
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
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
