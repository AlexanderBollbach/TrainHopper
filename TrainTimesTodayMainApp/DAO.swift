//
//  DAO.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 8/28/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation

import MapKit

public class DAO {
   
   var context = Context()
   let defaults = UserDefaults(suiteName: "group.AB.TrainTimesApp")!
   public static let sharedInstance = DAO()
   
   public func configureData() {
      
      
      getStationsFromPList()

      if Utilities.keyExists(defaults: defaults, key: "fromStation") {
         context.from = NSKeyedUnarchiver.unarchiveObject(with: defaults.object(forKey: "fromStation") as! Data) as! Station
      } else {
         context.from = Station()
      }
      
      if Utilities.keyExists(defaults: defaults, key: "toStation") {
         context.to = NSKeyedUnarchiver.unarchiveObject(with: defaults.object(forKey: "toStation") as! Data) as! Station
      } else {
         context.to = Station()
      }
      
      
   }
   
   
   public func getStations() -> [Station]? {
      
      return context.stations
   }
   


   
   func getStationsFromPList() {
      
      let data: Data!
      
      if let path = Bundle(identifier: "test.SharedCode")?.path(forResource: "StationsCache", ofType: "plist") {
         
         data = NSData(contentsOfFile: path) as Data!
      } else {
         data = Data()
      }
   
      let stationsFromPlist: [Station] = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Station]
      
      context.stations = stationsFromPlist

   }
   
   
   
   public func setStation(active: StationType, station: Station) {
      
      switch active {
         
      case .departing:
         context.from = station
         defaults.set(NSKeyedArchiver.archivedData(withRootObject: station), forKey: "fromStation")
         
      case .arriving:
         context.to = station
         defaults.set(NSKeyedArchiver.archivedData(withRootObject: station), forKey: "toStation")
      }
   }
   
   public func fetchTrips(completion: @escaping ([Trip]?) -> ()) {
      
      let from = context.from.abbr!
      let to = context.to.abbr!
      
      if from == "--" || to == "--" {
         completion(nil)
         return
      }

      Service_API.getTripsForStations(from: from, to: to) { (trips) in
         self.context.trips = trips
         completion(trips)
      }
      
   }
   
   public func getFromStation() -> Station {
      return context.from
   }
   
   
   public func getToStation() -> Station {
      return context.to
   }
   
}





// Map Support
extension DAO {
   
   public func getCoordinateList() -> [CLLocationCoordinate2D]? {
      return context.coordinatesFromTrips()
   }
   
   public func getCurrentTripsStops() -> [Stop]? {
      
      return context.trips?.first?.stops
   }
   
}














































// deprecated

extension DAO {
   
   
   
   
   
   func fetchStations() {
      
      
      if Utilities.keyExists(defaults: defaults, key: "stations") {
//         context.stations = NSKeyedUnarchiver.unarchiveObject(with: defaults.object(forKey: "stations") as! Data) as? [Station]
      } else {
         
//         getStationsFromService()
         
         
      }
      
      
   }
   
   
   func getStationsFromService() {
      
      
      
      
      
      Service_API.httpGetStations { (stations) in
         
         self.context.stations = stations.sorted { $0.name < $1.name }
         self.defaults.set(NSKeyedArchiver.archivedData(withRootObject: self.context.stations), forKey: "stations")
      }
   }
   
   
}
