//
//  Canvas.swift
//  PainterPS
//
//  Created by Tristan Pudell-Spatscheck on 11/15/19.
//  Copyright © 2019 Tristan Pudell-Spatscheck. All rights reserved.
//
import UIKit
struct Line {
    let color: UIColor
    let size: CGFloat
    var points: [CGPoint]
}
class Canvas: UIView {
    //variables
    var lines = [Line]()
    var color = UIColor.black
    var size = CGFloat(20)
    //functions
    override func draw(_ rect:CGRect){
        //custom drawing
        super.draw(rect)
        //sets up the context for drawing
        guard let context = UIGraphicsGetCurrentContext() else{
            return
        }
        //draws all lines
        lines.forEach { (line) in
            //sets up line's aesthetic
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.size)
            context.setLineCap(.round) //<- Makes lines end with curves
            //i=index, p=point in line, sets up each line
            for (i,p) in line.points.enumerated(){
                if i == 0{
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            //draws any line with current settings
            context.strokePath()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(color: color, size: size, points: [])) //<- Starts a new line for each new tap with new settings
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
        lastLn.points.append(point)
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
    func setSize(setSize: CGFloat){
        size = setSize
    }
    //sets color of line
    func setColor(setColor : UIColor){
        color = setColor
    }
}
