
import UIKit


@IBDesignable

class StationButton: UIButton {
//   
   var borderLayer: CAShapeLayer!
//
   override init(frame: CGRect) {
      super.init(frame: frame)
//      setup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
            setup()
   }
   
   override func layoutSubviews() {
      
      if (self.borderLayer != nil) {
         self.borderLayer?.frame = self.bounds
         self.borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5).cgPath
      }
      
      
   }
//
//   
   func setup() {
      
      self.borderLayer = CAShapeLayer()
      self.borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5).cgPath
      self.borderLayer.fillColor = UIColor(red: 55/255, green: 0, blue: 229 / 255, alpha: 1).cgColor
      self.layer.insertSublayer(self.borderLayer, below: self.titleLabel?.layer)
   }
//
}
