//
//  AchievmentViewController.swift
//  PongPS
//
//  Created by Tristan Pudell-Spatscheck on 3/4/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//

import Foundation
import UIKit
//MARK: global variables
var easyDubs = false
var goodPlayer = false
var godGamer = false
var breadWinner: Int = 0
class AchievmentViewController: UIViewController{
    //MARK: variables
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var easyDubsLbl: UILabel!
    @IBOutlet weak var goodPlayerLbl: UILabel!
    @IBOutlet weak var godGamerLbl: UILabel!
    @IBOutlet weak var breadWinnerLbl: UILabel!
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets text to the proper thing to display
        easyDubsLbl.text = "❌"
        goodPlayerLbl.text = "❌"
        godGamerLbl.text = "❌"
        breadWinnerLbl.text = "\(breadWinner)/10❌"
        if(easyDubs){
            easyDubsLbl.text = "✅"
        }
        if(goodPlayer){
            goodPlayerLbl.text = "✅"
        }
        if(godGamer){
            godGamerLbl.text = "✅"
        }
        if(breadWinner > 10){
            breadWinnerLbl.text = "\(breadWinner)/10✅"
        }
    }
    //MARK: functions
    //dismissed achievment view when back is pressed
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
