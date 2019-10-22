//
//  SettingsViewController.swift
//  WhichAmIPudell
//
//  Created by Tristan Pudell-Spatscheck on 10/21/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
import UIKit
class SettingsViewController: UIViewController{
    //connected variables
    @IBOutlet weak var preView: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var setBtn: UIButton!
    @IBOutlet weak var bckgSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets up the background enabled switch being on or off
        if(backEnabled){
            bckgSwitch.isOn = true
        } else {
            bckgSwitch.isOn = false
        }
        preView.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        preView.layer.borderWidth = 1
    }
    //previews color in 50x50 square
    @IBAction func previewPressed(_ sender: Any) {
        red=redSlider.value
        blue=blueSlider.value
        green=greenSlider.value
        print(red)
        print(blue)
        print(green)
        preView.backgroundColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
    //sets background color on actual quiz
    @IBAction func setPressed(_ sender: Any) {
        if(backEnabled){
        red=redSlider.value
        blue=blueSlider.value
        green=greenSlider.value
        //supposed to affect VC w/ quiz on it
        (presentingViewController as! ViewController).setBckg()
        }
    }
    //enables/disables background
    @IBAction func bckgToggled(_ sender: Any) {
        if(bckgSwitch.isOn == false){ //if disabled (saves old values and sets to white)
            backEnabled=false
            storedRed = red
            storedBlue = blue
            storedGreen = green
            red = 1
            blue = 1
            green = 1
        } else { //if enabled (gets stored values)
            backEnabled=true
            red = storedRed
            blue = storedBlue
            green = storedGreen
        }
        (presentingViewController as! ViewController).setBckg()
    }
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
