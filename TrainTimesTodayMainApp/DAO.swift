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

 
      fetchStationsFromNetwork()
      

      
   }
   
   
   
   
   public func getStations() -> [Station]? {
      
      return context.stations
      
      
   }
   
   
   public func getCurrentTripsStops() -> [Stop]? {
      
      
      return context.trips?.first?.stops
   }
   
   
   
   func fetchStationsFromNetwork() {
      
      Service_API.httpGetStations { (stations) in
         
         self.context.stations = stations.sorted { $0.name < $1.name }
         
      }
   }
   
   
   
   public func getCoordinateList() -> [CLLocationCoordinate2D]? {
      
      
      return context.coordinatesFromTrips()
      
      
   }
   
   
   
   public func setStation(active: StationType, station: Station) {
      
      switch active {
         
         
      case .departing:
         
         context.from = station
         
         
      case .arriving:
         
         context.to = station
      }
      
      
      
   }
   
   
   
   public func fetchTrips(completion: @escaping ([Trip]) -> ()) {
      
      
      
      let from = context.from.abbr!
      let to = context.to.abbr!
  
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
