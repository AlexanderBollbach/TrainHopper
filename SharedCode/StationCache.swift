//
//  StationCache.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 10/9/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation



class StationCache {
   
   
   public static let sharedInstance = StationCache()
   
   
   var plistPath: URL!
   
   
   init() {
      
      
      let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
      let url = NSURL(fileURLWithPath: path)
      plistPath = url.appendingPathComponent("stationsCache.plist")!
      let fileManager = FileManager.default
      if fileManager.fileExists(atPath: plistPath.path) {
         
         print("FILE AVAILABLE")
         
         
         
         
      } else {
         
         
         let emptyArr = [] as NSArray
         
         emptyArr.write(to: plistPath, atomically: true)
         
         print("FILE NOT AVAILABLE")
      }
      
   }
   
   
   
}
