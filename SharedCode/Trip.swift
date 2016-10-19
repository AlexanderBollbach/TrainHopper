//
//  Trip.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 10/5/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation

import MapKit

public struct Trip {
   
   
   var date: Date!
   var stops = [Stop]()
   
   
   init(date: Date) {
      self.date = date
   }
   
   
   mutating func addStop(stop: Stop) {
      
 
      stops.append(stop)

   }
   
   
   public func getFirstStopTime() -> String {
      
      let stop = stops.first!
      
      return stop.time
      
   }
   
   
   
   
   func getDepartureTime() -> String {
      
      return stops.first!.time
   }
   
   func getArrivalTime() -> String {
      
      return stops.last!.time
   }

   
}
