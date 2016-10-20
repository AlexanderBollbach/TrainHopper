//
//  CountdownView.swift
//  TrainTrackerLI
//
//  Created by alexanderbollbach on 10/17/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
import UIKit


class CountdownView: UIView {
   
   var contentView: UIView!
   
   @IBOutlet weak var backButton: UIButton!
   
   @IBOutlet weak var countDownLabel: UILabel!
   var nibName: String {
      return String(describing: type(of: self))
   }
   
   //MARK:
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      loadViewFromNib()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      
      loadViewFromNib()
   }
   
   
   
   
   
   //MARK:
   private func loadViewFromNib() {
      
    
      
      
      contentView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as! UIView
      contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      contentView.frame = bounds
      addSubview(contentView)
   }
}
