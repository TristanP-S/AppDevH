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
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var colorBtn: UIButton!
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var optionView: UIView!
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
        canvas.clear()
    }
    //color change clicked
    @IBAction func colorClicked(_ sender: Any) {
        //sets up color picker
        let actionSheet = UIAlertController(title: "Select a Color", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let red = UIAlertAction(title: "Red", style: .default) { action in
            self.colorSetter(color: .red, colName: "Red")
        }
        let black = UIAlertAction(title: "Black", style: .default) { action in
            self.colorSetter(color: .black, colName: "Black")
        }
        let green = UIAlertAction(title: "Green", style: .default) { action in
            self.colorSetter(color: .green, colName: "Green")
        }
        let blue = UIAlertAction(title: "Blue", style: .default) { action in
            self.colorSetter(color: .blue, colName: "Blue")
        }
        let white = UIAlertAction(title: "Eraser", style: .default) { action in
            self.colorSetter(color: .white, colName: "Eraser")
        }
        actionSheet.addAction(black)
        actionSheet.addAction(red)
        actionSheet.addAction(green)
        actionSheet.addAction(blue)
        actionSheet.addAction(white)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
        
    }
    func colorSetter(color: UIColor, colName: String){
        canvas.setColor(setColor: color)
        colorBtn.setTitle("Color: \(colName)", for: UIControl.State())
    }
    //slider value changed
    @IBAction func sliderChange(_ sender: Any) {
        canvas.setSize(setSize: CGFloat(sizeSlider.value))
        sizeLbl.text = "Size: \(Int(sizeSlider.value))"
    }
}

