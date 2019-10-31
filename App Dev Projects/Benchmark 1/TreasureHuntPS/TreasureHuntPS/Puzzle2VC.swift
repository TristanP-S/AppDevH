//
//  Puzzle2VC.swift
//  TreasureHuntPS
//
//  Created by Tristan Pudell-Spatscheck on 10/31/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import Foundation
import UIKit
class Puzzle2VC: UIViewController{
    var num7 = 0
    @IBOutlet weak var ranNumLbl: UILabel!
    @IBOutlet weak var answerTxt: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var promptLbl: UILabel!
    @IBOutlet weak var askBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(reset){
            self.dismiss(animated: true, completion: nil)
        } else {
            let num1 = Int.random(in: 1..<9)
            let num2 = Int.random(in: 1..<9)
            let num3 = Int.random(in: 1..<9)
            let num4 = Int.random(in: 1..<9)
            let num5 = Int.random(in: 1..<9)
            let num6 = Int.random(in: 1..<9)
            num7 = Int.random(in: 1..<9)
            let num8 = Int.random(in: 1..<9)
            let num9 = Int.random(in: 1..<9)
            ranNumLbl.text = "\(num1) \(num2) \(num3) \(num4) \(num5) \(num6) \(num7) \(num8) \(num9) "
        }
        promptLbl.text = "Memorize the following numbers to the best of your ability.When ready, hit \"Ask question\"."
        nextBtn.isHidden=true
        ranNumLbl.isHidden=false
        answerTxt.isHidden=true
        askBtn.isHidden=false
    }
    @IBAction func askQuestionClicked(_ sender: Any) {
         promptLbl.text = "What was the 7th number?"
        askBtn.isHidden=true
        ranNumLbl.isHidden=true
        nextBtn.isHidden=false
        answerTxt.isHidden=false
    }
    @IBAction func nextClicked(_ sender: Any) {
        if(answerTxt.text == String(num7)){
            points=points+1
        }
    }
}

