//
//  TimesCell.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 10/3/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation

import UIKit




class TripsCell: UITableViewCell {
   
   
   var departingLabel = UILabel()
   var arrivingLabel = UILabel()
   
   
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
   }
   
   required init?(coder aDecoder: NSCoder) {
      
      super.init(coder: aDecoder)
      
      
      commonInit()
   }
   
   
   
   
   
   
   func commonInit() {
      
      
      departingLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
      arrivingLabel.frame = CGRect(x: 100, y: 0, width: 100, height: 50)
      
      
      departingLabel.backgroundColor = UIColor.red
      departingLabel.backgroundColor = UIColor.green
      
      
      addSubview(departingLabel)
      addSubview(arrivingLabel)
      
      
      translatesAutoresizingMaskIntoConstraints = false
      departingLabel.translatesAutoresizingMaskIntoConstraints = false
      arrivingLabel.translatesAutoresizingMaskIntoConstraints = false
      
      self.backgroundColor = UIColor.red
      
      
      
      
   }
   
   
   
   
   override func layoutSubviews() {
      
//      setNeedsUpdateConstraints()
      
      
   }
   
   
   override func updateConstraints() {
      
      
      
      departingLabel.removeConstraints(departingLabel.constraints)
      arrivingLabel.removeConstraints(arrivingLabel.constraints)
      addConstraints()
      super.updateConstraints()
      
      
   }
   
   
   
   
   
   func addConstraints() {
      
      
      
      departingLabel.addConstraint(NSLayoutConstraint(item: departingLabel,
                                                                 attribute: .width,
                                                                 relatedBy: .equal,
                                                                 toItem: nil,
                                                                 attribute: .notAnAttribute,
                                                                 multiplier: 1.0,
                                                                 constant: 100))
      
      
      arrivingLabel.addConstraint(NSLayoutConstraint(item: arrivingLabel,
                                                      attribute: .width,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1.0,
                                                      constant: 100))
      
      addConstraints(
         
         [
            
            NSLayoutConstraint(item: departingLabel,
                               attribute: .left,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .left,
                               multiplier: 1,
                               constant: 0),
            
            
            
            NSLayoutConstraint(item: departingLabel,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .height,
                               multiplier: 1,
                               constant: 0),
            
            
 
            
            NSLayoutConstraint(item: departingLabel,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0)
            
         ]
         
      )
      
      
      addConstraints(
         
         [
            
            NSLayoutConstraint(item: arrivingLabel,
                               attribute: .right,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .right,
                               multiplier: 1,
                               constant: 0),
            
            
            
            NSLayoutConstraint(item: arrivingLabel,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .height,
                               multiplier: 1,
                               constant: 0),

            
            NSLayoutConstraint(item: arrivingLabel,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .centerY,
                               multiplier: 1.0,
                               constant: 0)
            
         ]
         
      )
      
      
   }
}


