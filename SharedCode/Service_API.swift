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
      
      let formatter = DateFormatter()
      
      
      let task = session.dataTask(with: request) { (data, response, error) -> Void in
         
    
         
         let jsonSw = JSON(data: data!)
   
         var tripsModel = [Trip]()
         
         let nowDate = Date()

         
         for (_,tripJSON) : (String, JSON) in jsonSw["TRIPS"] {
   
            
            
            // compare date of departures in each "trip" to now and check if it is in the past
            formatter.dateFormat = "yyyyMMdd"
            let thisDate = formatter.date(from: tripJSON["ROUTE_DATE"].stringValue)!
            
            
            formatter.dateFormat = "h:mm a"
            let firstStopTimeString = tripJSON["LEGS"].arrayValue[0]["STOPS"][0]["TIME"].stringValue
            let thisTripTimeDate = formatter.date(from: firstStopTimeString)!
            
            
            
            // add first stops time to thisDate
            var thisDateComponents = NSCalendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: thisDate)
            var thisTripTimeComponents = NSCalendar.current.dateComponents([.hour, .minute, .second], from: thisTripTimeDate)
            
            thisDateComponents.hour = thisTripTimeComponents.hour
            thisDateComponents.minute = thisTripTimeComponents.minute
            thisDateComponents.second = thisTripTimeComponents.second
            
            
            let completeThisDate = NSCalendar.current.date(from: thisDateComponents)!
            

            var trip = Trip(date: completeThisDate)
            
            if completeThisDate.compare(nowDate) == ComparisonResult.orderedAscending {
               continue
            }

            for leg in tripJSON["LEGS"].arrayValue {
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
