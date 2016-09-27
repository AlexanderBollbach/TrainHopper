//
//  ABViewController.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 7/23/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit
import NotificationCenter
import MMWormhole

class ABViewController: UIViewController {
   
   
   @IBOutlet weak var tableView: UITableView!
   let wormhole = MMWormhole(applicationGroupIdentifier: "group.AB.TrainTimesApp", optionalDirectory: "wormhole")
   var stationsTableView: UITableView!
   var stationTimes = [String]()
   var lirrAPI = LIRR_API()
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      wormhole.listenForMessage(withIdentifier: "stationChanged", listener: { (messageObject) -> Void in
         
         self.updateStationTimes()
         
         
         //         if let message: AnyObject = messageObject {
         //
         //
         //            var string = ""
         //            if let val = messageObject as? Dictionary<String,String> {
         //               string = val["ABKey"]!
         //            }
         //
         //
         //
         //         }
      })
      
      
//      self.stationsTableView.registerClass(ABCell.self, forCellReuseIdentifier: "ABCell")
      
      
      
 //     preferredContentSize = CGSizeMake(0, 600)
      
    
      
   }
   
   

   
   
   
   func updateStationTimes() {
      
      
      let defaults = UserDefaults(suiteName: "group.AB.TrainTimesApp")!
      
      guard let homeStation = defaults.string(forKey: "homeStation") else {
         return
      }
      
      guard let workStation = defaults.string(forKey: "workStation") else {
         return
      }
      
      
      lirrAPI.homeStation = homeStation
      lirrAPI.workStation = workStation
      
      
      lirrAPI.httpGet { asdf in
        
         self.stationTimes = asdf
         self.tableView.reloadData()
         
         
         
         self.preferredContentSize = self.tableView.contentSize
      }
      
      
   }
   
   func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
      // Perform any setup necessary in order to update the view.
      
      // If an error is encountered, use NCUpdateResult.Failed
      // If there's no update required, use NCUpdateResult.NoData
      // If there's an update, use NCUpdateResult.NewData
      
    //  updateStationTimes()
      
      completionHandler(NCUpdateResult.newData)
   }
   
//   
//   func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
//      return UIEdgeInsetsZero
//   }
   
   
   
   
   override func viewDidAppear(_ animated: Bool) {
      updateStationTimes()
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}



extension ABViewController: UITableViewDataSource {
   
   
   
   
   private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return stationTimes.count
   }
   
   
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      

      let cell = tableView.dequeueReusableCell(withIdentifier: "ABCell", for: indexPath) as! ABCell
      
      cell.label1.text = self.stationTimes[indexPath.row]
      
      
     
      return cell
   }
   
   
}


