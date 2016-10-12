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
   
   
   
   
   
   
   
   
   
   
   public static func getTripsForStations(from: String, to: String, completion: @escaping ([Trip])->())  {

      let urlString = "https://traintime.lirr.org/api/TrainTime?" +
         "api_key=742b288047c382c66326a26f7f5e4e4a&startsta=" + from + "&endsta=" + to
      
      let request = URLRequest(url: URL(string: urlString)!)
      let session = URLSession.shared
      
      let task = session.dataTask(with: request) { (data, response, error) -> Void in
         
    
         
         let jsonSw = JSON(data: data!)
         let trips = jsonSw["TRIPS"]
   
         var tripsModel = [Trip]()
         
         for (_,subJson) : (String, JSON) in trips {
   
            
            var trip = Trip()

            for leg in subJson["LEGS"].array! {
        
               for stop in leg["STOPS"].arrayValue {
       
                  trip.addStop(stop: Stop(time: stop["TIME"].stringValue, station: stop["STATION"].stringValue))
             
               }
            }
            
            
            tripsModel.append(trip)
 
         }
         
         DispatchQueue.main.sync {
            completion(tripsModel)
         }
      }
      task.resume()
 
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   public static func httpGetStations(completion: @escaping ([Station])->())  {
      
      
      var stations_store = [Station]()
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
            
            let station = Station(name: subJson["NAME"].stringValue,
                                       abbr: subJson["ABBR"].stringValue,
                                       lat: subJson["LATITUDE"].doubleValue,
                                       long: subJson["LONGITUDE"].doubleValue)
            
            stations_store.append(station)
         }
         
         
         DispatchQueue.main.sync {
            completion(stations_store)
         }
         
         
         
      }
      task.resume()
   }
   
   
   
}
