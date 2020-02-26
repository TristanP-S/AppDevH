/*
  ViewController.swift
  LightsaberPS
  Created by Tristan Pudell-Spatscheck on 2/24/20.
  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
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
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            //print(data as Any)
            if let trueData = data {
                let x = trueData.acceleration.x
                let y = trueData.acceleration.y
                let z = trueData.acceleration.z
                //plays sound if swing is detected unless indle in which case sabercrash plays (3 seems to be threshhold for movement)
                if(saberOn){
                    if((x > 1 || y > 1 || z > 1) && !self.musicPlayer.isPlaying){//if swung
                        self.playSound(sound: "saberSwing")
                        print("X: \(x), Y: \(y), Z:\(z)")
                    } else if (x < -2.5 || y < -2.5 || z < -5){ //plays 'saberCrash' if abruptly stoped (-accel)
                        self.playSound(sound: "saberCrash")
                        print("X: \(x), Y: \(y), Z:\(z)")
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

