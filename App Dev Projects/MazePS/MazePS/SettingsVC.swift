//
//  SettingsVC.swift
//  MazePS
//
//  Created by Tristan Pudell-Spatscheck on 12/5/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
import UIKit
import Foundation
class SettingsVC: UIViewController {
    @IBOutlet weak var mazeSizeTxt: UITextField!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        mazeSizeTxt.text = String(mazeSize)
    }
    @IBAction func backPressed(_ sender: Any) {
        //sets size to value in textBox, defaults to 11 if <0 or not set
        let size: Int = Int(mazeSizeTxt.text!)!
        if(size < 0){
            mazeSize = 11
        }
        else if(size % 2 == 0){
            mazeSize = size
        }
        else{
            mazeSize = size + 1
        }
        time = 0
        gameScene.nextLv()
        dismiss(animated: true, completion: nil)
    }
}
