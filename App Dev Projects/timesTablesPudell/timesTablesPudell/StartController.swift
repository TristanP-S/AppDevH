//
//  StartController.swift
//  timesTablesPudell
//
//  Created by Tristan Pudell-Spatscheck on 10/6/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import UIKit
import Foundation
class StartController: UIViewController{
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var startField: UITextField!
    //Times Table High Pt
    var timesNum = 12
    @IBAction func startClicked(_ sender: Any) {
        /* Tried to change the timesNum based on the text field, couldn't figure some issues out in time, so it was scrapped and the textbox was hidden
        //checks to make sure it's a number AND > 0
        if(startField.text != "Input Times Table Number Here"){
            if(Int(startField.text!) ?? 12>0){
            timesNum = Int(startField.text!)!
            }
    }
 */
    performSegue(withIdentifier: "startSegue", sender: self)
}
}
