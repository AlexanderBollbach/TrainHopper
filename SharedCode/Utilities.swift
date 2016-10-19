//
//  Utilities.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 10/8/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation

public class Utilities {
   
   
   
   class func keyExists(defaults: UserDefaults, key: String) -> Bool {
      return defaults.object(forKey: key) != nil
   }
   
   
   
   
   
   
   public class func printTime(with time: String) -> String {
      
      let formatter = DateFormatter()
      
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
         return "train departed"
      }
      
      
      let diffComps = Calendar.current.dateComponents([.hour, .minute, .second], from: startTime, to: endTime)
      
      let hoursToGo = diffComps.hour!
      let minsToGo = diffComps.minute!
      let secsToGo = diffComps.second!
      
      let concatComps = String(hoursToGo) +  ":" + String(minsToGo) + ":" + String(secsToGo)
      
      formatter.dateFormat = "HH:mm:ss"
      
      let formatedDate = formatter.date(from: concatComps)!
      
      let formatedDateAsString = formatter.string(from: formatedDate)
      
      return formatedDateAsString
      
   }

   
}
