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
   
   let formatter = DateFormatter()
   
   
   @IBOutlet weak var countDownLabel: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      
      
      
      countDownLabel.text = time

      
      
      Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
         self.printTime()
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
   
   
   
   func printTime() {
      
      
      
      let startTime = Date()
      
      formatter.dateFormat = "h:mm a"
      var endTime = formatter.date(from: time)!
      
      var componentsStart = NSCalendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startTime)
      var componentsEnd = NSCalendar.current.dateComponents([.hour, .minute, .second], from: endTime)
      
      componentsEnd.day = componentsStart.day
      componentsEnd.year = componentsStart.year
      componentsEnd.month = componentsStart.month
      
      endTime = Calendar.current.date(from: componentsEnd)!
      
      
      if !(endTime.timeIntervalSince(startTime) > 0) {
         
         countDownLabel.text = "train already departed"
         return
      }
      
      
      
      
      
      
      
      let diffComps = Calendar.current.dateComponents([.hour, .minute, .second], from: startTime, to: endTime)
      
      let hoursToGo = diffComps.hour!
      let minsToGo = diffComps.minute!
      let secsToGo = diffComps.second!
      
      let concatComps = String(hoursToGo) +  ":" + String(minsToGo) + ":" + String(secsToGo)
      
      formatter.dateFormat = "HH:mm:ss"
      
      let formatedDate = formatter.date(from: concatComps)!
      
      let formatedDateAsString = formatter.string(from: formatedDate)
      
      
      
      countDownLabel.text = formatedDateAsString//"\(hoursToGo) : \(minsToGo) : \(secsToGo)"
      
   }
   
}
