//
//  Canvas.swift
//  PainterPS
//
//  Created by Tristan Pudell-Spatscheck on 11/15/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//

import UIKit
class Canvas: UIView {
    var lines = [[CGPoint]]()
    override func draw(_ rect:CGRect){
        //custom drawing
        super.draw(rect)
        //sets up WHAT you are drawing (dots,circles, rectangles, etc.)
        guard let context = UIGraphicsGetCurrentContext() else{
            return
        }
        //draws all lines
        lines.forEach { (line) in
            //i=index, p=point in line, sets up each line
            for (i,p) in line.enumerated(){
                if i == 0{
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        //sets up line's aesthetic
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineCap(.butt) //<- Makes lines end with curves
        //draws any line with current settings
        context.strokePath()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]()) //<- Starts a new line for each new tap
    }
    //Finger tracking function
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //location you are touching
        guard let point = touches.first?.location(in: nil) else {
            return
        }
        //finds most recent line to add points touched to
        guard var lastLn = lines.popLast() else {
            return
        }
        lastLn.append(point)
        lines.append(lastLn)
        //redraws canvas after tracking point
        setNeedsDisplay()
    }
    //Undoes the last line
    func undo(){
        //removes last line
        _ = lines.popLast()
        //reloads canvas
        setNeedsDisplay()
    }
    //Clears all lines
    func clear(){
        //removes all lines
        lines.removeAll()
        //reloads canvas
        setNeedsDisplay()
    }
    //sets size of line
    func setSize(size: CGFloat){
        context.setLineWidth(size)
    }
    //sets color of line
    func setColor(color : CGColor){
        context.setStrokeColor(color)
    }
}
