//
//  Context.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 10/4/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
import MapKit


public class Context {
   
   
   var stations = [Station]()
   
   var from = Station()
   var to = Station()
   
   
   var trips: [Trip]?
   
   
   
   
   public func getScheduleFromTrip(atIndex index: Int) -> (String, String) {
      

      return ("test", "test")
      
   }
   
   
   
   func coordinatesFromTrips() -> [CLLocationCoordinate2D]? {
      
      
      guard let tripList = trips else {
         return nil
      }
      
      var coords = [CLLocationCoordinate2D]()
      
     
      let oneTripWillDo = tripList.first!
      
      
      for stop in oneTripWillDo.stops {
         
         
         coords.append(coordFromAbbr(abbr: stop.station)!)
         
      }
      
      
      return coords
      
   }
   
   func coordFromAbbr(abbr: String) -> CLLocationCoordinate2D? {
      

      
      
      for station in stations {
         
         if station.abbr == abbr {
            return station.coordinate
         }
         
         
      }
      
      
      return nil
   }
   
   
   
}
