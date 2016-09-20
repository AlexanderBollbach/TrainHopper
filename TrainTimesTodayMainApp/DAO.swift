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



struct Station {
   
   var FullName: String!
   var Abbr: String!
}



class DAO {
   
   
   
   var stations = [Station]()
   
   
   // IPC setup
   let defaults = NSUserDefaults(suiteName: "group.AB.TrainTimesApp")
   let wormhole = MMWormhole(applicationGroupIdentifier: "group.AB.TrainTimesApp", optionalDirectory: "wormhole")
   
   
   
   
   
    static let sharedInstance = DAO()
   
   
   
    func configureData() {
   
      httpGet { (stations) in
         
         self.stations = stations.sort{ $0.FullName < $1.FullName }
         
         
         
         
         
         
         
         
         
         self.synchronizeStations()
         
      }
      
   }
   
   
   
   func getStationList() -> [String] {
      
      return stations.map { $0.FullName }
      
      
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
   

   
   
   
   
   
   

   
   
   
   
   
   
   
      func httpGet(completion: [Station]->())  {
   
   
         var Stations = [Station]()
         let getStationsReq = "https://traintime.lirr.org/api/StationsAll?api_key=742b288047c382c66326a26f7f5e4e4a"
   
         let request = NSMutableURLRequest(URL: NSURL(string:
            getStationsReq)!)
         let session = NSURLSession.sharedSession()
   
   
         let task = session.dataTaskWithRequest(request) {
   
            (data, response, error) -> Void in
   
   
            let jsonSw = JSON(data: data!)
   
            if jsonSw == nil {
               return
            }
   
            let stations = jsonSw["Stations"]
   
            for (index,subJson):(String, JSON) in stations {
               Stations.append(Station(FullName: subJson["NAME"].stringValue, Abbr: subJson["ABBR"].stringValue))
            }
   
   
   
            dispatch_async(dispatch_get_main_queue()) {
               completion(Stations)
            }
            
         }
         task.resume()
      }
      

   
   
   
}
