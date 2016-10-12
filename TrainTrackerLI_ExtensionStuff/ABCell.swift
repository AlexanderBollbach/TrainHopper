//
//  ABCell.swift
//  TestAppExtension
//
//  Created by alexanderbollbach on 7/21/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit

class ABCell: UITableViewCell {
   
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      
      
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      backgroundColor = UIColor.blueColor()
   }
   
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   override func awakeFromNib() {
      print("test from all")
      self.backgroundColor = UIColor.blueColor()
   }

}
