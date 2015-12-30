//
//  DummyView.swift
//  Mango
//
//  Created by Florian Bauer on 29.12.15.
//  Copyright © 2015 Florian Bauer. All rights reserved.
//

import UIKit

@IBDesignable
class DummyView: UIView {
    
    @IBInspectable var text: String = "Default" {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var rotate: Bool = false
    @IBInspectable var bgColor: UIColor = UIColor.init(red: 0x53 / 255.0, green: 0x3A / 255.0, blue: 0x71 / 255.0, alpha: 1.0)
    @IBInspectable var boarderColor: UIColor = UIColor.init(red: 0x50 / 255.0, green: 0xC5 / 255.0, blue: 0xB7 / 255.0, alpha: 1.0)
    @IBInspectable var textColor: UIColor = UIColor.init(red: 0x9C / 255.0, green: 0xEC / 255.0, blue: 0x5B / 255.0, alpha: 1.0)

    let crossColor = UIColor.init(red: 0xF0 / 255.0, green: 0xF4 / 255.0, blue: 0x65 / 255.0, alpha: 1.0)
    
    
    
    let offset: CGFloat = 10.0
    
    private let paragraphStyle = NSMutableParagraphStyle()
    private var attrs = [String: AnyObject]()
    
    override func awakeFromNib() {
        paragraphStyle.alignment = .Center
        attrs[NSFontAttributeName] = UIFont(name: "HelveticaNeue-Thin", size: 20)!
        attrs[NSParagraphStyleAttributeName] = paragraphStyle
        attrs[NSForegroundColorAttributeName] = textColor
        
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context: CGContextRef = UIGraphicsGetCurrentContext()!;
        CGContextSaveGState(context);
        
        
        
        
        // background color
//        let strokeRect = CGRectInset(rect, 1.0, 1.0)
        CGContextSetStrokeColorWithColor(context, boarderColor.CGColor);
        CGContextSetFillColorWithColor(context, bgColor.CGColor)
        CGContextSetLineWidth(context, 1.0);
        CGContextFillRect(context, rect)
        CGContextStrokeRect(context, rect);
        
        
        
        // cross lines
        
        let path = UIBezierPath()
        
        path.moveToPoint(CGPoint(x: 0.0 + offset, y: 0.0 + offset))
        path.addLineToPoint(CGPoint(x: rect.width - offset, y: rect.height - offset))
        
        path.moveToPoint(CGPoint(x: 0.0 + offset, y: rect.height - offset))
        path.addLineToPoint(CGPoint(x:rect.width - offset, y: 0.0 + offset))
        
        
        CGContextSetStrokeColorWithColor(context, crossColor.CGColor)
        CGContextAddPath(context, path.CGPath)
        CGContextStrokePath(context)
        
        
        // text
        if rotate {
            // Rotate the context 90 degrees (convert to radians)
            let transform1: CGAffineTransform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2));
            CGContextConcatCTM(context, transform1);
            
            // Move the context back into the view
            CGContextTranslateCTM(context, -rect.size.height, 0);
            
            // text
            drawTextAtPoint(CGPoint(x: rect.height/2, y: rect.width/2))
        } else {
            // text
            drawTextAtPoint(CGPoint(x: rect.width/2, y: rect.height/2))
        }
        
        CGContextRestoreGState(context);
    }
    
    
    func drawTextAtPoint(point: CGPoint) {
        let textSize = text.sizeWithAttributes(attrs)
        
        let textRect = CGRect(x: point.x - textSize.width/2 - offset, y: point.y - textSize.height/2 - offset, width: textSize.width + offset*2, height: textSize.height + offset*2)
        
        let textRextPath = UIBezierPath(rect: textRect)
        textRextPath.fill()
        
        //CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), textColor.CGColor)
        //text.drawInRect(rect, withAttributes: attrs)
        text.drawAtPoint(CGPoint(x: point.x - textSize.width/2, y: point.y - textSize.height/2), withAttributes: attrs)
    }
}
