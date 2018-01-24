//
//  setCardView.swift
//  SetGame
//
//  Created by wesam Khallaf on 1/10/18.
//  Copyright © 2018 wesam Khallaf. All rights reserved.
//

import UIKit
@IBDesignable
class SetCardView: UIButton {
    
    @IBInspectable
    var number : Int = 3 { didSet{
        setNeedsDisplay()
        }
    }
    @IBInspectable
    var color : UIColor = UIColor.cyan { didSet{
        setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var isFaceUp : Bool = true { didSet{
        setNeedsDisplay()
        }
    }
    
    var symbole : Symbol = .oval { didSet{
        setNeedsDisplay()
        }
    }
    
    var shading : Shading = .hashed { didSet{
        setNeedsDisplay()
        }
    }
    
    lazy var cornerRadius : CGFloat = size.height / 5.0
    
    
    
    private lazy var  size : CGSize = CGSize(width: self.bounds.size.width * SizingRatio.widthRatio , height: self.bounds.size.height * SizingRatio.heightRatio)
    
    
    @IBInspectable      // an adapter to allow for the enum to be inspectable
    var symbolAdapter : String {
        
        get
        {
            return self.symbole.rawValue
        }
        
        set ( symbolIndex)
        {
            
            self.symbole = Symbol(rawValue: symbolIndex) ?? .squiggle
            
        }
    }
    
    @IBInspectable      // an adapter to allow for the enum to be inspectable
    var shaddingAdapter : String {
        
        get
        {
            return self.shading.rawValue
        }
        
        set ( shadingIndex)
        {
            
            self.shading = Shading(rawValue: shadingIndex) ??  .solid
            
        }
    }
    
    
    
    override func awakeFromNib() {
        // self.backgroundColor = UIColor.orange
    }
    
    
    
    override func draw(_ rect: CGRect) {
        
        
        
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        
        
        let roundRect=UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        roundRect.addClip()
        
        
        if self.isFaceUp == true {
            UIColor.gray.setFill()
            
            
        }
            
        else {
            UIColor.orange.setFill()
        }
        roundRect.fill()
        
        
        
        context?.restoreGState()
        
        
        
        
        if self.isFaceUp == true {
            
            let  xLocation :CGFloat = self.bounds.midX  - size.width/2
            
            let singleShapelocation : CGPoint = CGPoint(x: xLocation , y: self.bounds.midY - size.height / 3)
            let doubleShapelocation1 : CGPoint = CGPoint(x: xLocation, y: self.bounds.midY - size.height / 3 - 2 * size.height / 3 )
            
            let doubleShapelocation2 : CGPoint = CGPoint(x: xLocation , y: self.bounds.midY - size.height / 3 + 2 * size.height / 3 )
            
            let triippleShapelocation1 : CGPoint = CGPoint(x: xLocation, y: self.bounds.midY - size.height / 3 - 2 * size.height / 3)
            
            
            let triippleShapelocation2 : CGPoint = CGPoint(x: xLocation, y: self.bounds.midY - size.height / 5 )
            let triippleShapelocation3 : CGPoint = CGPoint(x: xLocation , y: self.bounds.maxY -  size.height / 2)
            
            var squiggleShapeLocation :[Int:[(CGPoint , CGFloat)]] = [1 : [(singleShapelocation , 0.9)]]
            
            squiggleShapeLocation[2] = [(doubleShapelocation1 , 0.9) , (doubleShapelocation2 , 0.9) ]
            squiggleShapeLocation[3] = [(triippleShapelocation1 , 0.6 ) , (triippleShapelocation2 , 0.6 ) , (triippleShapelocation3 , 0.6 )]
            
            
            
            
            if (self.symbole == .squiggle) {
                
                
                
                for array in squiggleShapeLocation[self.number]!
                {
                    drawSquiggleAtPoint(array.0 ,verticalScale: array.1)
                    
                    
                    
                }
                
                
            }
                
            else if self.symbole == .diamond {
                
                
                for array in squiggleShapeLocation[self.number]!
                {
                    drawDiamondShapeAt(array.0 ,verticalScale: array.1)
                  
                }
               
            }
                
            else if self.symbole == .oval
            {
                
                
                for array in squiggleShapeLocation[self.number]!
                {
                    drawOvalShapeAt(array.0 ,verticalScale: array.1)
 
                }
       
            }
            
        }
       
    }
    
    
    
    private func drawSquiggleAtPoint(_ point:CGPoint , verticalScale yScale : CGFloat)
        
        
    {
        
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 104.0, y: 15.0))
        
        path.addCurve(to: CGPoint(x: 63.0 , y: 54.0), controlPoint1: CGPoint(x: 112.4 , y: 36.9), controlPoint2: CGPoint(x: 89.7, y: 60.8))
        path.addCurve(to: CGPoint(x: 27.0 , y: 53.0), controlPoint1: CGPoint(x: 52.3 , y: 51.3), controlPoint2: CGPoint(x: 42.2, y: 42.0))
        path.addCurve(to: CGPoint(x: 5.0 , y: 40.0), controlPoint1: CGPoint(x: 9.6 , y: 65.6), controlPoint2: CGPoint(x: 5.4, y: 58.3))
        path.addCurve(to: CGPoint(x: 36.0 , y: 12.0), controlPoint1: CGPoint(x: 4.6 , y: 22), controlPoint2: CGPoint(x: 19.1, y: 9.7))
        path.addCurve(to: CGPoint(x: 89.0 , y: 14.0), controlPoint1: CGPoint(x: 59.2 , y: 15.2), controlPoint2: CGPoint(x: 61.9, y: 31.5))
        path.addCurve(to: CGPoint(x: 104.0 , y: 15.0), controlPoint1: CGPoint(x: 95.3 , y: 10), controlPoint2: CGPoint(x: 100.9, y: 6.9))
        
        
        scaleAndtranslatefPath(path, withScale: yScale, atPoint: point)
        
        
    }
    
    
    
    
    private func drawDiamondShapeAt(_ point:CGPoint , verticalScale yScale : CGFloat){
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 60 , y: 50.0))
        path.addLine(to: CGPoint(x: 115 , y: 100.0))
        path.addLine(to: CGPoint(x: 69 , y: 150.0))
        path.addLine(to: CGPoint(x: 10 , y: 100.0))
        path.addLine(to: CGPoint(x: 60 , y: 50))
        
        
        
        
        scaleAndtranslatefPath(path, withScale: yScale, atPoint: point)
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    private func drawOvalShapeAt(_ point:CGPoint , verticalScale yScale : CGFloat) {
        let radius : CGFloat = 30.0
        
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 20))
        
        path.addLine(to: CGPoint(x: 100, y: 20))
        
        
        path.addArc(withCenter: CGPoint(x: 100, y: 50), radius: radius , startAngle: (3 * Double.pi/2 ).cgfloat, endAngle: (Double.pi/2 ).cgfloat, clockwise: true)
        path.addLine(to: CGPoint(x: 20, y: 80))
        path.addArc(withCenter: CGPoint(x: 20, y: 50), radius: radius , startAngle:( Double.pi/2 ).cgfloat, endAngle: (3 * Double.pi/2 ).cgfloat, clockwise: true)
        
        
        scaleAndtranslatefPath(path, withScale: yScale, atPoint: point)
        
        
        
    }
    
    
    private func scaleAndtranslatefPath(_ path :UIBezierPath , withScale yScale : CGFloat , atPoint point:CGPoint) {
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 0.9 * size.width/100, y: yScale * size.height/100 * 0.9 * 0.5 )
        
        
        path.apply(transform)
        
        transform = CGAffineTransform(translationX:point.x, y: point.y)
        
        
        
        path.apply(transform)
        if self.shading == .solid {
            
            self.color.setFill()
            path.fill()
            
        }
            
        else if self.shading == .open {
            self.color.setStroke()
            path.stroke()
            
        }
            
            
        else if self.shading == .hashed {
            
            
            drawHashedPath(path)
            
        }
        
        
        
        
    }
    private func drawHashedPath(_ path : UIBezierPath) {
        
        self.color.setStroke()
        path.stroke()
        
        let  bounds : CGRect =  path.bounds;
        
        let stripes = UIBezierPath ()
        
        for x in stride(from: 0, through: Int(bounds.size.width), by: 10) {
            stripes.move(to: CGPoint(x: bounds.origin.x + CGFloat(x), y: bounds.origin.y))
            stripes.addLine(to: CGPoint(x: bounds.origin.x + CGFloat(x), y: bounds.origin.y + bounds.size.height))
            stripes.lineWidth = 5.0
        }
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        path.addClip()
        stripes.stroke()
        
        // drawing the outline of the shape
        context?.restoreGState()
        
        
        
        
        
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    
    
    
    enum Symbol : String {
        case diamond
        case  squiggle
        case oval
    }
    
    enum Shading : String {
        case solid
        case  hashed
        case open
    }
    
    
    
    
}
struct SizingRatio {
    static  let widthRatio : CGFloat = 0.5
    static let heightRatio : CGFloat = 0.4
}


extension Double {
    
    var cgfloat : CGFloat {
        return CGFloat(self)
    }
    
    
}
