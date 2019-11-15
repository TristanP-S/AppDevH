//
//  ViewController.swift
//  PainterPS
//
//  Created by Tristan Pudell-Spatscheck on 11/11/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    //outlets
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var canvasView: UIView!
    //variables
    let canvas = Canvas()
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //sets up canvas
        view.addSubview(canvas)
        canvas.frame = canvasView.frame
        canvas.backgroundColor = .white
    }
    //undo button clicked
    @IBAction func undoClicked(_ sender: Any) {
        canvas.undo()
    }
    //clear button clicked
    @IBAction func clearClicked(_ sender: Any) {
    }
}

