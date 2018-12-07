//
//  LogoGraphic.swift
//  BAH_Application
//
//  Created by Manciu, Bianca M on 12/6/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit
@IBDesignable


class LogoGraphic: UILabel {
    
    @IBInspectable var fillColor: UIColor = UIColor.white

    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        
        //set up the width and height variables
        //for the horizontal stroke
        let LogoWidth: CGFloat = min(bounds.width, bounds.height) * Constants.Scale
        let lineWidth = LogoWidth / 3
        
        
        //point 1
        let box1 = UIBezierPath(rect: CGRect (x: LogoWidth/2.5, y: thirdHeight-1.5, width: 2.5, height: 2.5))
        UIColor.white.setFill()
        box1.fill()
        
        //point 2
        let box2 = UIBezierPath(rect: CGRect (x: LogoWidth/2.5, y: (thirdHeight * 2) - 1.5, width: 2.5, height: 2.5))
        UIColor.white.setFill()
        box2.fill()
        
        //point 3
        let box3 = UIBezierPath(rect: CGRect (x: LogoWidth/2.5, y: (thirdHeight * 3) - 1.5, width: 2.5, height: 2.5))
        UIColor.white.setFill()
        box3.fill()
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = Constants.LineWidth
        
        //line 1
        plusPath.move(to: CGPoint(x: LogoWidth - lineWidth,y: thirdHeight))
        plusPath.addLine(to: CGPoint(x: LogoWidth + lineWidth, y: thirdHeight))
        
        //line 2
        plusPath.move(to: CGPoint(x: LogoWidth - lineWidth, y: thirdHeight * 2))
        plusPath.addLine(to: CGPoint(x: LogoWidth + lineWidth, y: thirdHeight * 2))
        
        
        //line 3
        plusPath.move(to: CGPoint(x: LogoWidth - lineWidth, y: thirdHeight * 3))
        plusPath.addLine(to: CGPoint(x: LogoWidth + lineWidth, y: thirdHeight * 3))
        
        //set the stroke color
        UIColor.white.setStroke()
        
        //draw the stroke
        plusPath.stroke()

    }
    
    private struct Constants {
        static let LineWidth: CGFloat = 1.5
        static let Scale: CGFloat = 0.6
    }
    
    private var thirdHeight: CGFloat {
        return bounds.height / 4
    }



    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
