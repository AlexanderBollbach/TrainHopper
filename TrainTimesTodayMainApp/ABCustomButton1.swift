//
//  ABCustomButton1.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 9/26/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit

@IBDesignable

public class ABCustomButton1: UIButton {


   let outline = CAShapeLayer()

   @IBInspectable var cornerRadius: CGFloat = 0 {
      didSet {
         outline.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
         outline.strokeColor = UIColor.black.cgColor
      }
   }
   
   @IBInspectable var bezierShapeColor: UIColor = UIColor.red
   
   
   
   
   
   
   
   
   required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
   }
   
   override init(frame: CGRect) {
      
      super.init(frame: frame)
      setup()
   }
   
   
   
   
   private func setup() {
   
      outline.frame = self.bounds
      self.layer.addSublayer(outline)
   
   }
   
   
   
   public override func layoutSubviews() {
    
      super.layoutSubviews()
      
      outline.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
      outline.fillColor = bezierShapeColor.cgColor
      
   }
   
//   public override func prepareForInterfaceBuilder() {
//      outline.fillColor = UIColor.blackColor().CGColor
//   }
   
   
   
}
