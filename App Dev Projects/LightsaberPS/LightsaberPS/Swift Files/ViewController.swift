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
var saberOn: Bool = false
class ViewController: UIViewController {
    //MARK: variables
    @IBOutlet weak var lightsaberBtn: UIButton!
    var musicPlayer : AVAudioPlayer = AVAudioPlayer()
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

