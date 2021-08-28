//
//  jkl.swift
//  thumbzapp
//
//  Created by Raja Vikram singh on 12/09/18.
//  Copyright © 2018 Raja Vikram singh. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomShapeView: UIView {
    
    @IBInspectable var color : UIColor? = UIColor.gray {
        didSet {
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //get the size of the view
        let size = self.bounds.size
        //get 4 points for the shape layer
        let p1 = self.bounds.origin
        let p2 = CGPoint(x: p1.x + size.width, y: p1.y)
        let p3 = CGPoint(x: p2.x, y: size.height)
        let p4 = CGPoint(x: p1.x, y: size.height - 70)
        
        //create the path
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.close()
        (color ?? UIColor.gray).set()
        path.fill()
        
    }
    
}



@IBDesignable
public class AngleView: UIView {
    
    @IBInspectable public var fillColor: UIColor = .blue { didSet { setNeedsLayout() } }
    
    var points: [CGPoint] = [
        .zero,
        CGPoint(x: 1, y: 0),
        CGPoint(x: 1, y: 1),
        CGPoint(x: 0, y: 0.5)
        ] { didSet { setNeedsLayout() } }
    
    private lazy var shapeLayer: CAShapeLayer = {
        let _shapeLayer = CAShapeLayer()
        self.layer.insertSublayer(_shapeLayer, at: 0)
        return _shapeLayer
    }()
    
    override public func layoutSubviews() {
        shapeLayer.fillColor = fillColor.cgColor
        
        guard points.count > 2 else {
            shapeLayer.path = nil
            return
        }
        
        let path = UIBezierPath()
        
        path.move(to: convert(relativePoint: points[0]))
        for point in points.dropFirst() {
            path.addLine(to: convert(relativePoint: point))
        }
        path.close()
        
        shapeLayer.path = path.cgPath
    }
    
    private func convert(relativePoint point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x * bounds.width + bounds.origin.x, y: point.y * bounds.height + bounds.origin.y)
    }
}





