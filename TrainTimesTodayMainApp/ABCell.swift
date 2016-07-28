//
//  ABCell.swift
//  TestAppExtension
//
//  Created by alexanderbollbach on 7/21/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit

class ABCell: UITableViewCell {
   
   @IBOutlet weak var label1: UILabel!
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      
      
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)

   }
   
   
   override func awakeFromNib() {
      print("test from all")
//      self.backgroundColor = UIColor.blueColor()
   }

}
