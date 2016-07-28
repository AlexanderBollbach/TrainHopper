//
//  LIRR_API.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 7/23/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation

import SwiftyJSON


class LIRR_API {
   
   
   var homeStation: String!
   var workStation: String!
   
   
   
   func httpGet(completion: [String]->())  {
      
      
      var departTimes = [String]()
      
      let request = NSMutableURLRequest(URL: NSURL(string:
         "https://traintime.lirr.org/api/TrainTime?api_key=742b288047c382c66326a26f7f5e4e4a&startsta="+homeStation+"&endsta="+workStation)!)
      let session = NSURLSession.sharedSession()
      
      
      let task = session.dataTaskWithRequest(request) {
         
         (data, response, error) -> Void in
         
         
         let jsonSw = JSON(data: data!)
         
         
         let trips = jsonSw["TRIPS"]
         
         for (index,subJson):(String, JSON) in trips {
            
            let legs = subJson["LEGS"][0]
            
            let stops = legs["STOPS"].arrayValue
            
            let initialStop = stops[0].dictionaryValue
            
            let initialStopTime = initialStop["TIME"]?.stringValue
            
//            let departTime = legs["DEPART_TIME"].stringValue
//            let arriveTime = legs["ARRIVE_TIME"].stringValue
            
            departTimes.append(initialStopTime!)

         }
         
         
         
         
         dispatch_async(dispatch_get_main_queue()) {
            
            completion(departTimes)
         }
         
         
         
         
      }
      task.resume()
   }
   
   
}