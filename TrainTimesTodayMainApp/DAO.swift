//
//  DAO.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 8/28/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
import MMWormhole
import SwiftyJSON


class DAO {
   
   
   var fromStation = StationModel()
   var toStation = StationModel()
   
   var stations = [StationModel]()
   
   
   // IPC setup
   let defaults = UserDefaults(suiteName: "group.AB.TrainTimesApp")!
   let defaults_standard = UserDefaults()
   let wormhole = MMWormhole(applicationGroupIdentifier: "group.AB.TrainTimesApp", optionalDirectory: "wormhole")
   
   static let sharedInstance = DAO()
   
   
   func configureData() {
      
      
      if let stations = defaults_standard.value(forKey: "stations") {
         
         

         self.stations = NSKeyedUnarchiver.unarchiveObject(with: stations as! Data) as! [StationModel]
         
         return
      }
      
      
      httpGet { (stations) in
         
         self.stations = stations.sorted{ $0.name < $1.name }
         
         self.defaults_standard.set(NSKeyedArchiver.archivedData(withRootObject: self.stations), forKey: "stations")
         
         //         self.synchronizeStations()
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
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   func httpGet(completion: @escaping ([StationModel])->())  {
      
      
      var stations_store = [StationModel]()
      let getStationsReq = "https://traintime.lirr.org/api/StationsAll?api_key=742b288047c382c66326a26f7f5e4e4a"
      
      let request = URLRequest(url: URL(string: getStationsReq)!)
      let session = URLSession.shared
      
      
      let task = session.dataTask(with: request) {
         
         (data, response, error) -> Void in
         
         
         let jsonSw = JSON(data: data!)
         
         if jsonSw == nil {
            return
         }
         
         let stations = jsonSw["Stations"]
         
         for (_,subJson):(String, JSON) in stations {
        
            let station = StationModel(name: subJson["NAME"].stringValue, abbr: subJson["ABBR"].stringValue, lat: subJson["LATITUDE"].floatValue, long: subJson["LONGITUDE"].floatValue)
            stations_store.append(station)
         }
         
         
         DispatchQueue.main.sync {
            completion(stations_store)
         }
         
         
         
      }
      task.resume()
   }
   
   
   
   
   
}
