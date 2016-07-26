//
//  ViewController.swift
//  TestAppExtension
//
//  Created by alexanderbollbach on 7/10/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit
import MMWormhole

import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

   @IBOutlet weak var homePickerView: UIPickerView!
   @IBOutlet weak var workPickerView: UIPickerView!
   
   
   let wormhole = MMWormhole(applicationGroupIdentifier: "group.AB.TrainTimesApp", optionalDirectory: "wormhole")

   
   let pickerData = ["NYK", "BWN"]
  
   
   let defaults = NSUserDefaults(suiteName: "group.AB.TrainTimesApp")

   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      

    
      httpGet { (yyy) in
         
      }
      
      
      
 
      
 
      
   }

      
   
   
   
   
   
   
   
   //MARK: - Delegates and data sources
   //MARK: Data Sources
   func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
      return 1
   }
   func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return pickerData.count
   }
   
   
   func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return pickerData[row]
   }
   
   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
      let station = pickerData[row]
      
//      print(pickerData[row])
      
      if pickerView == homePickerView {
        
         defaults!.setObject(station, forKey: "homeStation")
         defaults!.synchronize()
         
         
         
      } else if pickerView == workPickerView {
         
         defaults!.setObject(station, forKey: "workStation")
         defaults!.synchronize()
         
      }
      
      
      wormhole.passMessageObject(["homeStation" : station], identifier: "stationChanged")
      

   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   

}



extension ViewController {
   
   
   
   
   
   func httpGet(completion: [String]->())  {
      
      
      var departTimes = [String]()
      
      let getStationsReq = "https://traintime.lirr.org/api/StationsAll?api_key=742b288047c382c66326a26f7f5e4e4a"
      
      
      
      let request = NSMutableURLRequest(URL: NSURL(string:
         getStationsReq)!)
      let session = NSURLSession.sharedSession()
      
      
      let task = session.dataTaskWithRequest(request) {
         
         (data, response, error) -> Void in
         
         
         let jsonSw = JSON(data: data!)
         
         
         let stations = jsonSw["Stations"]
         
         for (index,subJson):(String, JSON) in stations {
            
           
            
            print(subJson["NAME"])
            
         }
         
         
         
         
         dispatch_async(dispatch_get_main_queue()) {
            
            completion(departTimes)
         }
         
         
         
         
      }
      task.resume()
   }
   
   
}

