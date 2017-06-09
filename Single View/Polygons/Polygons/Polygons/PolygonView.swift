//
//  PolygonView.swift
//  Polygons
//
//  Created by Kurt McMahon on 11/8/16.
//  Copyright (c) 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class PolygonView: UIView, UIGestureRecognizerDelegate {
    
    var rotation: CGFloat = 0
    var scale: CGFloat = 0.9
    var color: UIColor = UIColor.redColor()
    
    weak var delegate: PolygonViewDelegate?

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()

        CGContextSaveGState(context)
        
        // Rotate context to rotation angle.
        let contextCenter = CGPointMake(CGRectGetMidX(bounds),
            CGRectGetMidY(bounds))
        CGContextTranslateCTM(context, contextCenter.x, contextCenter.y)
        CGContextRotateCTM(context, rotation)
        CGContextTranslateCTM(context, -contextCenter.x, -contextCenter.y)
        
        // Get points for polygon.
        let pointsArray = pointsForPolygon(contextCenter)
        
        // Draw polygon.
        let path = UIBezierPath()
        path.moveToPoint(pointsArray[0].CGPointValue())
        
        for index in 1..<pointsArray.count {
            path.addLineToPoint(pointsArray[index].CGPointValue())
        }
        
        path.closePath()
        
        color.setFill()
        color.setStroke()
        
        path.fill()
        path.stroke()

        CGContextRestoreGState(UIGraphicsGetCurrentContext())
    }
    
    // Compute points on circle for polygon.
    func pointsForPolygon(center: CGPoint) -> [NSValue] {
        var result: [NSValue] = []
        
        let smallestDimension = (center.x < center.y) ? center.x : center.y
        let radius = Double(scale) * Double(smallestDimension)
        
        let angle = (2.0 * M_PI) / Double(delegate!.numberOfSides())
        let exteriorAngle = M_PI - angle
        let rotationDelta = angle - (0.5 * exteriorAngle)
        
        for currentAngle in 0..<delegate!.numberOfSides() {
            let newAngle = (angle * Double(currentAngle)) - rotationDelta
            let currentX = cos(newAngle) * radius
            let currentY = sin(newAngle) * radius
            let point = CGPointMake(center.x + CGFloat(currentX),
                center.y + CGFloat(currentY))
            let pointObject = NSValue(CGPoint: point)
            result.append(pointObject)
        }
        
        return result
    
    }
        
    func reset() {
        rotation = 0
        scale = 0.9
        color = UIColor.redColor()
        alpha = 1.0
        setNeedsDisplay()
    }
    
    
    @IBAction func handlePinch(sender: UIPinchGestureRecognizer) {
//        print("I have been Pinched")
        if sender.view != nil {
            scale = sender.scale
            setNeedsDisplay()
        }
    
    }
    
    @IBAction func handleRotation(sender: UIRotationGestureRecognizer) {
       // print("I have been Rotated")
        if sender.view != nil {
            rotation = sender.rotation
            setNeedsDisplay()
        }
    }
    
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        //print("I have been Tapped")
        if sender.view != nil {
            alpha -= 0.1
            setNeedsDisplay()
        }
    }
    
    @IBAction func handleSwipe(sender: UISwipeGestureRecognizer) {
        //print("I have been Swiped")
        if sender.view != nil {
            if color == UIColor.redColor() {
                color = UIColor.blueColor()
            }
            
            else if color == UIColor.blueColor() {
                color = UIColor.greenColor()
            }
            
            else {
                color = UIColor.redColor()
            }
            
            setNeedsDisplay()
        }

    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
