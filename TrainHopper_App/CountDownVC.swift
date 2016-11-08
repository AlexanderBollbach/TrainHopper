//
//  CountdownVC.swift
//  TrainTrackerLI
//
//  Created by alexanderbollbach on 10/15/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
import UIKit
import SharedCode

class CountDownVC : UIViewController {
   
   var time: String!
   
   
   
   @IBOutlet weak var countDownLabel: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      countDownLabel.text = time
      
      
      
      Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
         self.countDownLabel.text = Utilities.printTime(with: self.time)//self.printTime(with: self.time)
         }.fire()
      
   }
   
   
   
   
   override func viewWillAppear(_ animated: Bool) {
      DAO.sharedInstance.inCountDownMode = true
      
      print(DAO.sharedInstance.inCountDownMode)
   }
   override func viewWillDisappear(_ animated: Bool) {
      DAO.sharedInstance.inCountDownMode = false
      print(DAO.sharedInstance.inCountDownMode)
   }
   
      
}
