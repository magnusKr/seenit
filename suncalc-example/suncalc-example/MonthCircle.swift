//
//  MonthCircle.swift
//  suncalc-example
//
//  Created by Magnus Kraepelien on 04/05/16.
//  Copyright © 2016 Chimani, LLC. All rights reserved.
//

import UIKit


class MonthCircle : UIView {
    
    let size: CGFloat = 800.0
    
    let lineWidth: CGFloat = 3
    
    var rotationTotal: CGFloat = 0
    
    var dotdiameter: CGFloat!
    
    var dotspacing: CGFloat!
    
    
    
    
    init()
    {
        super.init(frame: CGRectMake(0.0, 0.0, size, size))
        //self.center = origin
        self.backgroundColor = UIColor.clearColor()
        drawCircle()
        drawDots()
       
    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
        let insetRect = CGRectInset(rect, lineWidth/2, lineWidth/2)
        
        let path = UIBezierPath(roundedRect: insetRect, cornerRadius: 20)

        path.lineWidth = self.lineWidth
        //UIColor.blackColor().setStroke()
      //  path.stroke()
    }
    
    func drawDots()  {
        
        let circlePath = UIBezierPath(arcCenter: self.center, radius: CGFloat(size/2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)

//        
        let dashes: [CGFloat] = [0, 140]
//        circlePath.setLineDash(dashes, count: 12, phase: 2)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        shapeLayer.lineDashPattern = dashes
        shapeLayer.lineCap = kCALineJoinRound
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        //you can change the line width
        shapeLayer.lineWidth = 10.0
        
        self.layer.addSublayer(shapeLayer)
        
    }
    func drawCircle()  {
        
        let circlePath = UIBezierPath(arcCenter: self.center, radius: CGFloat(size/2), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
 
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        
   
        
        //change the fill color
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        //you can change the stroke color
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        //you can change the line width
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
        
    }


    
}

extension UIView {
    /**
     Set x Position
     
     :param: x CGFloat
     by DaRk-_-D0G
     */
    func setX(x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    /**
     Set y Position
     
     :param: y CGFloat
     by DaRk-_-D0G
     */
    func setY(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    /**
     Set Width
     
     :param: width CGFloat
     by DaRk-_-D0G
     */
    func setWidth(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    /**
     Set Height
     
     :param: height CGFloat
     by DaRk-_-D0G
     */
    func setHeight(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
}
