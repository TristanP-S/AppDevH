//
//  FinalVC.swift
//  TreasureHuntPS
//
//  Created by Tristan Pudell-Spatscheck on 10/31/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import Foundation
import UIKit
class FinalVC: UIViewController{
    @IBOutlet weak var resultImg: UIImageView!
    @IBOutlet weak var resultLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(points==2){
            resultLbl.text = "You got the treasure treasure! Score: \(points)"
            resultImg.image = UIImage(named: "treasurechest")
        } else {
            resultLbl.text = "You didn't get the treasure treasure! Score: \(points)"
            resultImg.image = UIImage(named: "lockedtreasurechest")
        }
        points=0
    }
    @IBAction func resetClicked(_ sender: Any) {
        points=0
    }
}

