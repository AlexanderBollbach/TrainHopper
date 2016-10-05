//
//  SelectedStationModel.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 9/26/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
import MapKit


final public class Station : NSObject, NSCoding {
   
   
   public init?(coder aDecoder: NSCoder) {
      name = aDecoder.decodeObject(forKey: "name") as! String
      abbr = aDecoder.decodeObject(forKey: "abbr") as! String
      lat = aDecoder.decodeObject(forKey: "lat") as! Double
      long = aDecoder.decodeObject(forKey: "long") as! Double
   }

  
   
   public func encode(with aCoder: NSCoder) {
      aCoder.encode(name, forKey: "name")
      aCoder.encode(abbr, forKey: "abbr")
      aCoder.encode(lat, forKey: "lat")
      aCoder.encode(long, forKey: "long")
   }
   
   

   
   public var coordinate: CLLocationCoordinate2D {

      get {
         return CLLocationCoordinate2D(latitude: lat, longitude: long)
      }
   }
   
   
   public var name: String!
   public var abbr: String!
   public var lat: Double!
   public var long: Double!
   
   public init(name: String, abbr: String, lat: Double, long: Double) {
      
      self.name = name
      self.abbr = abbr
      self.lat = lat
      self.long = long
   }
   
   
   
   public convenience override init() {
    
      
      self.init(name: "---", abbr: "---", lat: 40, long: 70)
   }
   
   
   
}
