//
//  ViewController.swift
//  ButtonClick
//
//  Created by Tristan Pudell-Spatscheck on 9/9/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //outlets (connects button + label)
    @IBOutlet weak var clickMe: UIButton!
    @IBOutlet weak var lblClick: UILabel!
    //when screen loads
    override func viewDidLoad() {
        super.viewDidLoad()
        lblClick.isHidden = true
        // Do any additional setup after loading the view.
    }
    //when button is clicked
    @IBAction func btnClick(_ sender: Any) {
        lblClick.text = "Button Clicked"
        lblClick.isHidden = false
    }
    

}

