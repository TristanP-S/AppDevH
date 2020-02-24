//
//  ViewController.swift
//  LightsaberPS
//
//  Created by Tristan Pudell-Spatscheck on 2/24/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//
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
            musicPlayer.numberOfLoops = 1
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
                //plays sound if swing is detected unless indle in which case sabercrash plays
                if(x > 0.5){
                    self.playSound(sound: "saberSwing")
                } else if (y > 0.5) {
                    self.playSound(sound: "saberSwing")
                } else if (z > 0.5) {
                    self.playSound(sound: "saberSwing")
                } else {
                    self.playSound(sound: "saberCrash")
                }
            }
        }
    }
    //toggles lightsaber on or off
    @IBAction func lightsaberToggle(_ sender: Any) {
        if(saberOn){
            lightsaberBtn.setImage(UIImage(named: "lightsaberOff"), for: .normal)
            playSound(sound: "saberOff")
            saberOn = false
        } else {
            lightsaberBtn.setImage(UIImage(named: "lightsaberOn"), for: .normal)
            playSound(sound: "saberOn")
            saberOn = true
        }
    }
}

