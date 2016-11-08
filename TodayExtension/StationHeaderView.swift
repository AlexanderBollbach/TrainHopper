//
//  StationHeaderView.swift
//  TrainTrackerLI
//
//  Created by alexanderbollbach on 11/7/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit

class StationHeaderView: UIView {

   
   var contentView: UIView!
   
   
   @IBOutlet weak var departingStationLabel: UILabel!
   
   @IBOutlet weak var arrivingStationLabel: UILabel!
   
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
