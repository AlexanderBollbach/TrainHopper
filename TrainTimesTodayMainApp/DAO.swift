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
   
   
   var fromStation: SelectedStationModel = SelectedStationModel(stationName: "Baldwin")
   var toStation: SelectedStationModel = SelectedStationModel(stationName: "Penn Station")
   
   var stations = [[String : String]]()
   
   
   // IPC setup
   let defaults = UserDefaults(suiteName: "group.AB.TrainTimesApp")!
   let defaults_standard = UserDefaults()
   let wormhole = MMWormhole(applicationGroupIdentifier: "group.AB.TrainTimesApp", optionalDirectory: "wormhole")
   
   static let sharedInstance = DAO()
   
   
   func configureData() {
      
      
      if let stations = defaults_standard.value(forKey: "stations") {
         
         self.stations = stations as! [[String : String]]
         
         return
      }
      
      
      httpGet { (stations) in
         
         self.stations = stations.sorted{ $0["name"]! < $1["name"]! }
         
         self.defaults_standard.set(self.stations, forKey: "stations")
         
         //         self.synchronizeStations()
      }
      
   }
   
   
   
   func getStationList() -> [String] {
      
      return stations.map { $0["name"]! }
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
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   func httpGet(completion: @escaping ([[String : String]])->())  {
      
      
      var stations_store = [[String : String]]()
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
            
            
            let dict1 = ["name": subJson["NAME"].stringValue, "abbr": subJson["ABBR"].stringValue]
            stations_store.append(dict1)
         }
         
         
         DispatchQueue.main.sync {
            completion(stations_store)
         }
         
         
         
      }
      task.resume()
   }
   
   
   
   
   
}
