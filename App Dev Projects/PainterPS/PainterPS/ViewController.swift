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
        //i=index, p=point in line
        for (i,p) in line.enumerated(){
            if i == 0{
                context.move(to: p)
            } else {
                context.addLine(to: p)
            }
        }
        context.strokePath()
    }
    //Finger tracking function
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //location you are touching
        guard let point = touches.first?.location(in: nil) else {
            return
        }
        //print(point) <- print location tapped
        line.append(point)
        //redraws canvas
        setNeedsDisplay()
    }
}
class ViewController: UIViewController {
    let canvas = Canvas()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(canvas)
        canvas.frame = view.frame
        canvas.backgroundColor = .white
    }


}

