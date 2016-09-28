//
//  ABCustomButton1.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 9/26/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit

@IBDesignable

public class StationButton: UIButton {
   
   
   let transferLayer = CAShapeLayer()
   
   var bezierShapeColor: UIColor = UIColor.red
   
   
   let cornerRadius: CGFloat = 0
   //   @IBInspectable var cornerRadius: CGFloat = 0 {
   //      didSet {
   //         transferLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
   //      }
   //   }
   //
   //   @IBInspectable var bezierShapeColor: UIColor = UIColor.red
   //
   //
   //
   
   
   
   
   
   required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
   }
   
   override init(frame: CGRect) {
      
      super.init(frame: frame)
      setup()
   }
   
   
   
   
   private func setup() {
      
      transferLayer.frame = self.bounds
      
      transferLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
      transferLayer.fillColor = bezierShapeColor.cgColor
      
      
      self.layer.addSublayer(transferLayer)
      
      
      
      
   }
   
   
   
   public override func layoutSubviews() {
      
      
      print("layout called")
      
      transferLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
      
      super.layoutSubviews()
      
      
      
   }
   
   
      //
   //   public override func prepareForInterfaceBuilder() {
   //      transferLayer.fillColor = bezierShapeColor.cgColor
   //   }
   //
   
   
   
      func hideLayer() {
         self.transferLayer.isHidden = true
      }
   
   
      func unhideLayer() {
         self.transferLayer.isHidden = false
      }
   
   
   
      func getLayerCopy() -> CAShapeLayer {
   
         let arched = NSKeyedArchiver.archivedData(withRootObject: self.transferLayer)
   
         let copiedLayer = NSKeyedUnarchiver.unarchiveObject(with: arched) as! CAShapeLayer
   
         copiedLayer.isHidden = false
         
         return copiedLayer
         
      }

}
