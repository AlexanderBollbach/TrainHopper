//
//  ABHeaderView.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 7/23/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit

class ABHeaderView: UIView {

   
   var label: UILabel!
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      label = UILabel(frame: frame)
      self .addSubview(label)
      
      label.text = "this"
      
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
}


