//
//  Puzzle3VC.swift
//  TreasureHuntPS
//
//  Created by Tristan Pudell-Spatscheck on 10/31/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import Foundation
import UIKit
//THIS DIDN'T WORK BECAUSE IT HAD CONSTRAINT PROBLEMS, GRADE AS YOU DEEM NECESSARY
class Puzzle3VC: UIViewController{
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var OneBtn: UIButton!
    @IBOutlet weak var TwoBtn: UIButton!
    @IBOutlet weak var ThreeBtn: UIButton!
    @IBOutlet weak var FourBtn: UIButton!
    @IBOutlet weak var FiveBtn: UIButton!
    @IBOutlet weak var SixBtn: UIButton!
    @IBOutlet weak var SevenBtn: UIButton!
    @IBOutlet weak var EightBtn: UIButton!
    @IBOutlet weak var NineBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(reset){
            self.dismiss(animated: true, completion: nil)
        } else{
        enableBtns(enabled: true)
        }
    }
    func enableBtns(enabled: Bool){
        OneBtn.isEnabled=enabled
        TwoBtn.isEnabled=enabled
        ThreeBtn.isEnabled=enabled
        FourBtn.isEnabled=enabled
        FiveBtn.isEnabled=enabled
        SixBtn.isEnabled=enabled
        SevenBtn.isEnabled=enabled
        EightBtn.isEnabled=enabled
        NineBtn.isEnabled=enabled
    }
    @IBAction func oneClicked(_ sender: Any) {
        let num1 = Int.random(in: 1..<9)
        if(num1==1){
            points = points + 1
        }
        enableBtns(enabled: false)
    }
    @IBAction func twoClicked(_ sender: Any) {
        let num1 = Int.random(in: 1..<9)
        if(num1==2){
            points = points + 1
        }
        enableBtns(enabled: false)
    }
    @IBAction func threeClicked(_ sender: Any) {
        let num1 = Int.random(in: 1..<9)
        if(num1==3){
            points = points + 1
        }
        enableBtns(enabled: false)
    }
    @IBAction func fourClicked(_ sender: Any) {
        let num1 = Int.random(in: 1..<9)
        if(num1==4){
            points = points + 1
        }
        enableBtns(enabled: false)
    }
    @IBAction func fiveClicked(_ sender: Any) {
        let num1 = Int.random(in: 1..<9)
        if(num1==5){
            points = points + 1
        }
        enableBtns(enabled: false)
    }
    @IBAction func sixClicked(_ sender: Any) {
        let num1 = Int.random(in: 1..<9)
        if(num1==6){
            points = points + 1
        }
        enableBtns(enabled: false)
    }
    @IBAction func sevenClicked(_ sender: Any) {
        let num1 = Int.random(in: 1..<9)
        if(num1==7){
            points = points + 1
        }
        enableBtns(enabled: false)
    }
    @IBAction func eightClicked(_ sender: Any) {
        let num1 = Int.random(in: 1..<9)
        if(num1==8){
            points = points + 1
        }
        enableBtns(enabled: false)
    }
    @IBAction func nineClicked(_ sender: Any) {
        let num1 = Int.random(in: 1..<9)
        if(num1==9){
            points = points + 1
        }
        enableBtns(enabled: false)
    }
}

