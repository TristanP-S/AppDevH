//
//  buttonsVC.swift
//  PongPS
//
//  Created by Tristan Pudell-Spatscheck on 11/19/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
import Foundation
import UIKit
import SpriteKit
var gamemode = 1 //default to easy mode
class buttonsVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //enable/disables buttons
    func btnEnable(){
        
    }
    @IBAction func easyPressed(_ sender: Any) {
        gamemode = 1
        TitleScene().presentGame()
    }
    @IBAction func normalPressed(_ sender: Any) {
        gamemode = 2
        TitleScene().presentGame()
    }
    @IBAction func expertPressed(_ sender: Any) {
        gamemode = 3
        TitleScene().presentGame()
    }
    @IBAction func multiplayerPressed(_ sender: Any) {
        gamemode = 4
        TitleScene().presentGame()
    }
}
