//
//  CheckMarkBox.swift
//  LBCheckBox
//
//  Created by Justin Ji on 15/04/2018.
//  Copyright © 2018 Justin Ji. All rights reserved.
//

import UIKit

class CheckMarkBox: UIView {

    public var borderWidth: CGFloat = 1
    public var borderColour: UIColor = .red
    public var boxBackgroundColour: UIColor = .white
    public var checkedCircleColour: UIColor = .black
    public var checkBoxType: CheckBoxBorderStyle = .square
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        switch checkBoxType {
        case .square: addSquareMarkBox(rect)
        case .circle: addRoundMarkBox(rect)
        }
    }

    var insetRect: CGRect?

    private func addRoundMarkBox(_ rect: CGRect) {
        insetRect = rect.insetBy(dx: borderWidth, dy: borderWidth)
        let circlePath = UIBezierPath(ovalIn: insetRect!)
        borderColour.setStroke()
        circlePath.lineWidth = borderWidth
        circlePath.stroke()
        boxBackgroundColour.setFill()
        circlePath.fill()
    }
    
    private func addSquareMarkBox(_ rect: CGRect) {
        
        let insetRect = rect.insetBy(dx: borderWidth, dy: borderWidth)
        let retangularPath = UIBezierPath(rect: insetRect)
        borderColour.setStroke()
        retangularPath.lineWidth = borderWidth
        retangularPath.stroke()
        boxBackgroundColour.setFill()
        retangularPath.fill()
    }
    
    private var shapeLayer: CAShapeLayer?
    private var thickPath: UIBezierPath?
    private var thickShapeLayer: CAShapeLayer?
    
    public func deselectSquareBox() {
        
        thickPath = nil
        thickShapeLayer = nil
        self.layer.sublayers = nil
        self.setNeedsDisplay()
    }
    
    public func selectSquareBox() {
        thickPath = UIBezierPath()
        thickPath?.move(to: CGPoint(x: self.borderWidth + 1, y: 10))
        thickPath?.addLine(to: CGPoint(x: self.bounds.size.height * 2/5, y: self.bounds.size.height - (self.borderWidth + 1)))
        thickPath?.addLine(to: CGPoint(x: self.bounds.size.width - (borderWidth + 1), y: borderWidth + 1))
        
        thickShapeLayer = CAShapeLayer()
        thickShapeLayer?.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        thickShapeLayer?.strokeColor = borderColour.cgColor
        thickShapeLayer?.lineWidth = 2
        thickShapeLayer?.path = thickPath?.cgPath
        
        self.layer.addSublayer(thickShapeLayer!)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.5
        thickShapeLayer?.add(animation, forKey: "MyAnimation")
        
        // save shape layer
        self.shapeLayer = thickShapeLayer
    }
    
    
    var innerView: UIView?
    
    public func selectCircleBox() {
        
        innerView = UIView(frame: (insetRect?.insetBy(dx: 1, dy: 1))!)
        innerView?.layer.cornerRadius = ((insetRect?.height)! - 1)/2
        innerView?.backgroundColor = checkedCircleColour
        addSubview(innerView!)
    }
    
    public func deselectCircleBox() {
        innerView?.removeFromSuperview()
        innerView = nil
    }
}













































































