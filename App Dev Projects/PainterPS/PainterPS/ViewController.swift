//
//  ViewController.swift
//  PainterPS
//
//  Created by Tristan Pudell-Spatscheck on 11/11/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import UIKit
class Canvas: UIView {
    override func draw(_ rect:CGRect){
        //custom drawing
        super.draw(rect)
        //sets up WHAT you are drawing (dots,circles, rectangles, etc.)
        guard let context = UIGraphicsGetCurrentContext() else{
            return
        }
        let startPt =  CGPoint(x: 0, y: 0)
        let endPt = CGPoint(x: 100, y: 100)
        context.move(to: startPt)
        context.addLine(to: endPt)
        context.strokePath()
    }
    //Finger tracking function
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //location you are touching
        guard let point = touches.first?.location(in: nil) else {
            return
        }
        print(point)
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

