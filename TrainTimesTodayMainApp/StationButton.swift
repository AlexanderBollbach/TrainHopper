






import UIKit


@IBDesignable

class StationButton: UIButton {
   
   var contentView : UIView?
   
   var borderLayer: CAShapeLayer!
   
   var stationType: ActiveStationType!
   
   
   @IBOutlet weak var name: UILabel!
   
   @IBInspectable @IBOutlet weak var iconView: UIImageView!
   
   @IBInspectable var iconImage: UIImage? {
      didSet {
         self.iconView.image = iconImage
      }
   }
   override init(frame: CGRect) {
      super.init(frame: frame)
      xibSetup()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      xibSetup()
   }
   
   
   
   override func layoutSubviews() {
      
 
      
      self.borderLayer?.frame = self.bounds
      self.borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5).cgPath
   }
   func xibSetup() {
     
      
      contentView = loadViewFromNib()
      
      // use bounds not frame or it'll be offset
      contentView!.frame = bounds
      
      // Make the view stretch with containing view
      contentView!.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
      
      
      // Adding custom subview on top of our view (over any custom drawing > see note below)
      addSubview(contentView!)
      
      self.borderLayer = CAShapeLayer()
      self.borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5).cgPath
      self.borderLayer.strokeColor = UIColor.black.cgColor
      self.borderLayer.fillColor = UIColor.clear.cgColor
      self.layer.addSublayer(self.borderLayer)
      
      
      

   }
   
   
   
   
   
   
   func loadViewFromNib() -> UIView! {
      
      
      
      let bundle = Bundle(for: type(of: self))
      
      let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
      let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
      
      return view
   }
   
}
