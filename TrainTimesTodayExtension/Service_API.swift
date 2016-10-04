//
//  LIRR_API.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 7/23/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Service_API {
   
   
   public static func httpGetStationTimes(from: String, to: String, completion: @escaping ([TripModel])->())  {
      
      
      
      
      func getTimeWithAbbr(abbr: String, stops: [JSON]) -> String? {
         
         for stop in stops {
            
            
            if stop.dictionaryValue["STATION"]?.stringValue == abbr {
               return stop.dictionaryValue["TIME"]!.stringValue
            }
         }
         
         return nil
         
      }
      
      
      var tripTimes = [TripModel]()
      let urlString = "https://traintime.lirr.org/api/TrainTime?" +
         "api_key=742b288047c382c66326a26f7f5e4e4a&startsta=" + from + "&endsta=" + to
      
      let request = URLRequest(url: URL(string: urlString)!)
      let session = URLSession.shared
      
      let task = session.dataTask(with: request) {
         (data, response, error) -> Void in
         
         let jsonSw = JSON(data: data!)
         let trips = jsonSw["TRIPS"]
         
         for (_,subJson):(String, JSON) in trips {
            
            let legs = subJson["LEGS"].array!
            
            let firstLeg = legs.first!
            let lastLeg = legs.last!
            
            let stops1 = firstLeg["STOPS"].arrayValue
            let stops2 = lastLeg["STOPS"].arrayValue
            
            
            
            
            let departingTime = getTimeWithAbbr(abbr: from, stops: stops1)!
            let arrivingTime = getTimeWithAbbr(abbr: to, stops: stops2)!

//            let arriveTime = legs["ARRIVE_TIME"].stringValue
            
            let trip = TripModel(departing: departingTime, arriving: arrivingTime)
            tripTimes.append(trip)
            
         }
         
         DispatchQueue.main.sync {
            completion(tripTimes)
         }
      }
      task.resume()
      
      
      
      
     
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   public static func httpGetStations(completion: @escaping ([StationModel])->())  {
      
      
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
