//
//  DAO.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 8/28/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
import MMWormhole
import SharedCode

class DAO {
   
   var fromStation = StationModel()
   var toStation = StationModel()
   var activeStation = ActiveStation.departing
   var stations = [StationModel]()
   
   // IPC setup
   let defaults = UserDefaults(suiteName: "group.AB.TrainTimesApp")!
//   let wormhole = MMWormhole(applicationGroupIdentifier: "alexander bollbach.group.AB.TrainTimesApp", optionalDirectory: "wormhole")
   static let sharedInstance = DAO()
   
   func configureData() {
      
      
      
      
      if let stations = defaults.value(forKey: "stations") {
         self.stations = NSKeyedUnarchiver.unarchiveObject(with: stations as! Data) as! [StationModel]
      } else {
         fetchStationsFromNetwork()
      }
      
      if let fromStationDefault = defaults.value(forKey: "fromStation") {
      
         fromStation = NSKeyedUnarchiver.unarchiveObject(with: fromStationDefault as! Data) as! StationModel
         
      } else {
         fromStation = StationModel()
      }
      
      if let toStationDefault = defaults.value(forKey: "toStation") {
         
         toStation = NSKeyedUnarchiver.unarchiveObject(with: toStationDefault as! Data) as! StationModel
         
      } else {
         toStation = StationModel()
      }

      
      
      
      
 
      
      
   }
   
   
   
   
   func fetchStationsFromNetwork() {
      Service_API.httpGetStations { (stations) in
         
         self.stations = stations.sorted{ $0.name < $1.name }
         
         self.defaults.setValue(NSKeyedArchiver.archivedData(withRootObject: self.stations), forKey: "stations")
         
         self.defaults.setValue(NSKeyedArchiver.archivedData(withRootObject: self.fromStation), forKey: "fromStation")
         
         
         self.defaults.setValue(NSKeyedArchiver.archivedData(withRootObject: self.toStation), forKey: "toStation")
         
         
      }
   }
   
   
   func setActiveStation(station: StationModel) {
      switch activeStation {
      case .departing:
         fromStation = station
         self.defaults.set(NSKeyedArchiver.archivedData(withRootObject: self.fromStation), forKey: "fromStation")
      case .arriving:
         toStation = station
         self.defaults.set(NSKeyedArchiver.archivedData(withRootObject: self.toStation), forKey: "toStation")
      }
   }
   
   

   func getStationList() -> [StationModel] {
      return stations
   }
   
   
   func synchronizeStations() {
      
      //
      //            let homeRow = self.homePickerView.selectedRowInComponent(0)
      //            let workRow = self.workPickerView.selectedRowInComponent(0)
      //
      //            let pickedHomeStation = stations[homeRow].Abbr
      //            let pickedWorkStation = stations[workRow].Abbr
      //
      //            defaults!.setObject(pickedHomeStation, forKey: "homeStation")
      //            defaults!.setObject(pickedWorkStation, forKey: "workStation")
      //            defaults!.synchronize()
      //
      //            // notify Extension
      //            wormhole.passMessageObject("test", identifier: "stationChanged")
      
      //
      
   }
   
  
   
}
