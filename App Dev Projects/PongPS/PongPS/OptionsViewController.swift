//
//  OptionsViewController.swift
//  PongPS
//
//  Created by Tristan Pudell-Spatscheck on 11/21/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import Foundation
import UIKit
//MARK: global variables
var topColor: UIColor = UIColor(ciColor: .red)
var bottomColor: UIColor = UIColor(ciColor: .green)
var ballColor: UIColor = UIColor(ciColor: .yellow)
var god = false
var eGod = false
var music = true
class OptionsViewController: UIViewController{
    //MARK: variables
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var topPaddleButton: UIButton!
    @IBOutlet weak var bottomPaddleButton: UIButton!
    @IBOutlet weak var ballButton: UIButton!
    @IBOutlet weak var godSwitch: UISwitch!
    @IBOutlet weak var eSwitch: UISwitch!
    @IBOutlet weak var musicSwitch: UISwitch!
    var choice = "top"
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        topPaddleButton.backgroundColor = topColor
        bottomPaddleButton.backgroundColor = bottomColor
        ballButton.backgroundColor = ballColor
        godSwitch.isOn = god
        eSwitch.isOn = eGod
        musicSwitch.isOn = music
        if(music){
            gameVC.playSong(song: "ElevtorSong")
        }
    }
    //MARK: functions
    //lets user pick a color
    func pickAColor(button: UIButton){
        let actionSheet = UIAlertController(title: "Select a Color", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let red = UIAlertAction(title: "Red", style: .default) { action in
            self.setColor(color: UIColor(ciColor: .red), button2: button)
        }
        let black = UIAlertAction(title: "Black", style: .default) { action in
            self.setColor(color: UIColor(ciColor: .black), button2: button)
        }
        let green = UIAlertAction(title: "Green", style: .default) { action in
            self.setColor(color: UIColor(ciColor: .green), button2: button)
        }
        let yellow = UIAlertAction(title: "Yellow", style: .default) { action in
            self.setColor(color: UIColor(ciColor: .yellow), button2: button)
        }
        let white = UIAlertAction(title: "White", style: .default) { action in
            self.setColor(color: UIColor(ciColor: .white), button2: button)
        }
        actionSheet.addAction(black)
        actionSheet.addAction(red)
        actionSheet.addAction(green)
        actionSheet.addAction(yellow)
        actionSheet.addAction(white)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    func setColor(color: UIColor, button2: UIButton){
        //changes color once choice is actually made
        if(choice == "top"){
            topColor = color
        }
        else if (choice == "bottom"){
            bottomColor = color
        } else {
            ballColor = color
        }
        button2.backgroundColor = color
        print("PICKED \(color)")
    }
    //button functions
    @IBAction func backPressed(_ sender: Any) {
        gameVC.playSong(song: "PBRSunnyPark")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func topPaddleColorPressed(_ sender: Any) {
        choice = "top"
        pickAColor(button: topPaddleButton)
    }
    @IBAction func bottomPaddleColorPressed(_ sender: Any) {
        choice = "bottom"
        pickAColor(button: bottomPaddleButton)
    }
    @IBAction func ballColorPressed(_ sender: Any) {
        choice = "ball"
        pickAColor(button: ballButton)
    }
    @IBAction func godSwitched(_ sender: Any) {
        if(godSwitch.isOn){
            god = true
        }
        else{
            god = false
        }
    }
    @IBAction func eSwitched(_ sender: Any) {
        if(eSwitch.isOn){
            eGod = true
        }
        else{
            eGod = false
        }
    }
    @IBAction func musicSwitched(_ sender: Any) {
        if(musicSwitch.isOn){
            music = true
        }
        else{
            music = false
        }
        gameVC.playSong(song: "ElevtorSong")
    }
    
}
