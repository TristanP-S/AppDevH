//
//  ViewController.swift
//  PainterPS
//
//  Created by Tristan Pudell-Spatscheck on 11/11/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import UIKit
class Canvas: UIView {
    var line = [CGPoint]()
    override func draw(_ rect:CGRect){
        //custom drawing
        super.draw(rect)
        //sets up WHAT you are drawing (dots,circles, rectangles, etc.)
        guard let context = UIGraphicsGetCurrentContext() else{
            return
        }
        //i=index, p=point in line, sets up the line
        for (i,p) in line.enumerated(){
            if i == 0{
                context.move(to: p)
            } else {
                context.addLine(to: p)
            }
        }
        //sets up line's aesthetic
        context.setLineWidth(CGFloat(20))
        context.setStrokeColor(UIColor.red.cgColor)
        //draws any line with current settings
        context.strokePath()
    }
    //Finger tracking function
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //location you are touching
        guard let point = touches.first?.location(in: nil) else {
            return
        }
        line.append(point)
        //redraws canvas after tracking point
        setNeedsDisplay()
    }
}
class ViewController: UIViewController {
    
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var canvasView: UIView!
    let canvas = Canvas()
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
    }
    //clear button clicked
    @IBAction func clearClicked(_ sender: Any) {
    }
}

