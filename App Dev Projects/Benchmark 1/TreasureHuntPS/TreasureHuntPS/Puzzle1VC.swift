//
//  Puzzle1VC.swift
//  TreasureHuntPS
//
//  Created by Tristan Pudell-Spatscheck on 10/31/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import Foundation
import UIKit
var points=0
var reset = false
class Puzzle1VC: UIViewController{
    var num1: Int = 0
    var num2: Int = 0
    @IBOutlet weak var mathPrbLbl: UILabel!
    @IBOutlet weak var answerTxt: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(reset){
            points=0
            self.dismiss(animated: true, completion: nil)
        } else {
            num1 = Int.random(in: 0..<9)
            num2 = Int.random(in: 0..<9)
            mathPrbLbl.text = "\(num1) * \(num2)"
        }
    }
    @IBAction func nextClicked(_ sender: Any) {
        if(answerTxt.text == String(num1*num2)){
            points=points+1
        }
    }
}
