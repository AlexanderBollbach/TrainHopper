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


struct Station {
   
   var FullName: String!
   var Abbr: String!
}



class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
   @IBOutlet weak var homePickerView: UIPickerView!
   @IBOutlet weak var workPickerView: UIPickerView!
   
   
   // TV datasource
   var stations = [Station]()
   
   
   
   // IPC setup
   let defaults = NSUserDefaults(suiteName: "group.AB.TrainTimesApp")
   let wormhole = MMWormhole(applicationGroupIdentifier: "group.AB.TrainTimesApp", optionalDirectory: "wormhole")
   
   
   
   
   
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      httpGet { (stations) in
         
         self.stations = stations.sort{ $0.FullName < $1.FullName }
         
         self.homePickerView.reloadAllComponents()
         self.workPickerView.reloadAllComponents()
         
         
         self.homePickerView.selectRow(6, inComponent: 0, animated: true)
         self.workPickerView.selectRow(92, inComponent: 0, animated: true)
         
         
         self.synchronizeStations()
         
      }
      
      
      
      
      
      
   }
   
   
   func synchronizeStations() {
      
      
      let homeRow = self.homePickerView.selectedRowInComponent(0)
      let workRow = self.workPickerView.selectedRowInComponent(0)
      
      let pickedHomeStation = stations[homeRow].Abbr
      let pickedWorkStation = stations[workRow].Abbr
      
      defaults!.setObject(pickedHomeStation, forKey: "homeStation")
      defaults!.setObject(pickedWorkStation, forKey: "workStation")
      defaults!.synchronize()
      
      // notify Extension
      wormhole.passMessageObject("test", identifier: "stationChanged")
      
      
      
   }
   
   
   
   
   
   
   
   
   
   
   
   //MARK: - Delegates and data sources
   //MARK: Data Sources
   func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
      return 1
   }
   func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return stations.count
   }
   
   func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return stations[row].FullName
   }
   
   
   
   
   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
      let station = stations[row].Abbr
      
      
      if pickerView == homePickerView {
        
         
         
         
      } else if pickerView == workPickerView {
         
        
         
      }
      
    
      
      
      self.synchronizeStations()
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}



extension ViewController {
   
   func httpGet(completion: [Station]->())  {
      
      
      var Stations = [Station]()
      let getStationsReq = "https://traintime.lirr.org/api/StationsAll?api_key=742b288047c382c66326a26f7f5e4e4a"
      
      let request = NSMutableURLRequest(URL: NSURL(string:
         getStationsReq)!)
      let session = NSURLSession.sharedSession()
      
      
      let task = session.dataTaskWithRequest(request) {
         
         (data, response, error) -> Void in
         
         
         let jsonSw = JSON(data: data!)
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

