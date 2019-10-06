//
//  ViewController.swift
//  timesTablesPudell
//
//  Created by Tristan Pudell-Spatscheck on 10/3/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
/*GENERAL NOTES:
-LAYOUT TESTED+WORKING ON iPad Pro (3rd gen, 12.9 in), iPhone 6, iPhone 8, iPhone X (all the gens that can be tested with the simulator)
 -Went a different route of more of a "self-study"/motivated user that would simply check their own answers and study until they were confident (no score, highscore, timer, etc.), simply tells them they were wrong, and they can skip problems at will
-Press Cmd+k to show the keyboard a normal phone would have, using normal keyboard breaks app, as it was designed for a phone(with a forced number pad), so having the letters of a normal keyboard (only possible in the emualtor) breaks the application in various ways.
-As stated in startController, my plans for custom timesTables failed, so I simply set it to the default 12x tables. (Upper+Lower bounds would've been set correct though)
 */
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
        //done button setup
        //makes a toolbar which has its size set to fit its location
        let doneBar = UIToolbar()
        doneBar.sizeToFit()
        //adds the done button with the type "done" (for the name) which runs doneClicked when tapped
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
        //adds the done button to the toolbar
        doneBar.setItems([doneBtn], animated: false)
        //toolbar is added as an "acessory view" for the numpad opened when the responseBox is tapped
        responseBox.inputAccessoryView = doneBar
    }
    //makes done button close the numpad
    @objc func doneClicked(){
        view.endEditing(true)
    }
    //Next button pressed (next problem loads), resets once all have been done
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
        while(i<=StartController().timesNum){
            while(j<=StartController().timesNum){
                problems.append(Problem(prompt: "\(i) * \(j)", answer: i*j))
                j=j+1
            }
            j=1
            i=i+1
        }
        problems.shuffle()
    }
}

