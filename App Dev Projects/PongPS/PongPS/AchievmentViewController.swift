//
//  AchievmentViewController.swift
//  PongPS
//
//  Created by Tristan Pudell-Spatscheck on 3/4/20.
//  Copyright © 2020 Tristan Pudell-Spatscheck. All rights reserved.
//

import Foundation
import UIKit
class AchievmentViewController: UIViewController{
    //MARK: variables
    @IBOutlet weak var backBtn: UIButton!
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: functions
    //dismissed achievment view when back is pressed
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
