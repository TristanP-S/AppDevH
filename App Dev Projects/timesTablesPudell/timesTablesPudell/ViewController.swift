//
//  ViewController.swift
//  timesTablesPudell
//
//  Created by Tristan Pudell-Spatscheck on 10/3/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import UIKit
import Foundation
struct Problem{
    var prompt:String
    var answer:Int
}
//current problem
var current = 0
class ViewController: UIViewController {
    //connected variables
    @IBOutlet weak var promptLbl: UILabel!   //prompt EX: 2*2
    @IBOutlet weak var responseLbl: UILabel!  //response: WRONG or RIGHT
    @IBOutlet weak var checkBtn: UIButton!  //checks for correctness
    @IBOutlet weak var nextBtn: UIButton!  //loads next problem
    @IBOutlet weak var responseBox: UITextField!  //where the user inputs their answer
    //array of problems
    var problems = [Problem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        current = 0
        responseLbl.isHidden = true
        randomize()
        promptLbl.text = problems[current].prompt
    }
    //Next button pressed (next problem loads)
    @IBAction func nextPressed(_ sender: Any) {
        responseLbl.isHidden = true
        responseBox.text = ""
        if(current<(problems.count-1)){
            current=current+1
        } else {
            current=0
        }
        promptLbl.text = problems[current].prompt
    }
    //checks answer via the array
    @IBAction func checkPressed(_ sender: Any) {
        if(responseBox.text == ""){
            responseBox.text = "0"
        }
        if((Int(responseBox.text!))==problems[current].answer){
            responseLbl.text = "Correct"
        } else {
           responseLbl.text = "Wrong"
        }
        responseLbl.isHidden=false
    }
    //makes list of times tables for i and j and then shuffles(randomizes) it
    func randomize(){
        var i = 1
        var j = 1
        while(i<=12){
            while(j<=12){
                problems.append(Problem(prompt: "\(i) * \(j)", answer: i*j))
                j=j+1
            }
            j=1
            i=i+1
        }
        problems.shuffle()
    }
}

