/*
  ViewController.swift
  LightsaberPS
  Created by Tristan Pudell-Spatscheck on 2/24/20.
  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
Note: Used Gyroscope instead of accelerometer as it measues the current speed (aka hard swings) a lot better.
 */
import Foundation
import UIKit
import AVFoundation
import CoreMotion
var saberOn: Bool = false
class ViewController: UIViewController {
    //MARK: variables
    @IBOutlet weak var lightsaberBtn: UIButton!
    var musicPlayer : AVAudioPlayer = AVAudioPlayer()
    var motionManager : CMMotionManager = CMMotionManager()
    //MARK: functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lightsaberBtn.setImage(UIImage(named: "lightsaberOff"), for: .normal)
        setupGyro()
    }
    //plays a given song on repeat
    func playSound(sound: String){
        musicPlayer.stop()
            do{
                let sound1 = Bundle.main.path(forResource: sound, ofType: "mp3")
                try musicPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: sound1!) as URL)
            } catch {
                print("NO SONG FILE for \(sound)")
            }
            musicPlayer.numberOfLoops = 0
            musicPlayer.play()
    }
    //Sets up gyroscope sensor data
    func setupGyro(){
        motionManager.gyroUpdateInterval = 0.1
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            //print(data as Any)
            if let trueData = data {
                let x = trueData.rotationRate.x
                let y = trueData.rotationRate.y
                let z = trueData.rotationRate.z
                print("X: \(x), Y: \(y), Z:\(z)")
                //plays sound if swing is detected unless indle in which case sabercrash plays (3 seems to be threshhold for movement)
                if(saberOn){
                    if(x > 5 || y > 5 || z > 5){
                        self.playSound(sound: "saberSwing")
                    } else if (!self.musicPlayer.isPlaying){ //plays 'saberCrash' if nothing else is playing
                        self.playSound(sound: "saberCrash")
                    }
                }
            }
        }
    }
    //toggles lightsaber on or off
    @IBAction func lightsaberToggle(_ sender: Any) {
        if((UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown) && !saberOn){ //checks that device is in portrait mode when turned on
            lightsaberBtn.setImage(UIImage(named: "lightsaberOn"), for: .normal)
            playSound(sound: "saberOn")
            saberOn = true
        } else if (saberOn){
            lightsaberBtn.setImage(UIImage(named: "lightsaberOff"), for: .normal)
            playSound(sound: "saberOff")
            saberOn = false
        }
    }
}

