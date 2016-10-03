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
import SharedCode

class ABViewController: UIViewController {
   
   
   var fromStation: StationModel!
   var toStation: StationModel!
   
   
   @IBOutlet weak var tableView: UITableView!
   let wormhole = MMWormhole(applicationGroupIdentifier: "group.AB.TrainTimesApp", optionalDirectory: "wormhole")
   let defaults = UserDefaults(suiteName: "group.AB.TrainTimesApp")!
   var stationTimes = [String]()
   
   
   
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      
      
      
      if defaults.value(forKey: "fromStation") != nil {
         fromStation = NSKeyedUnarchiver.unarchiveObject(with: defaults.value(forKey: "fromStation") as! Data) as! StationModel!
      } else {
         fromStation = StationModel()
      }
      
      if defaults.value(forKey: "toStation") != nil {
         toStation = NSKeyedUnarchiver.unarchiveObject(with: defaults.value(forKey: "toStation") as! Data) as! StationModel!
      } else {
         toStation = StationModel()
      }
      //
      //      wormhole.listenForMessage(withIdentifier: "stationChanged", listener: { (messageObject) -> Void in
      //
      //         self.updateStationTimes()
      //
      //      })
      
      
      
      preferredContentSize = CGSize(width: 0, height: 600)
      
      
      
   }
   
   
   override func viewDidAppear(_ animated: Bool) {
      
    
      
      Service_API.httpGetStationTimes(from: fromStation.abbr, to: toStation.abbr) { (times) in
         self.stationTimes = times
         self.tableView.reloadData()
      }
      
   }
   
   
   
   func updateStationTimes() {
      
      
      
      
      //      guard let homeStation = defaults.string(forKey: "homeStation") else {
      //         return
      //      }
      //
      //      guard let workStation = defaults.string(forKey: "workStation") else {
      //         return
      //      }
      
      
      //      lirrAPI.homeStation = homeStation
      //      lirrAPI.workStation = workStation
      
      
      //      lirrAPI.httpGet { asdf in
      //
      //         self.stationTimes = asdf
      //         self.tableView.reloadData()
      //
      
      
      //         self.preferredContentSize = self.tableView.contentSize
      //      }
      
      
   }
   
   

   func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {

      
      
      completionHandler(NCUpdateResult.newData)
   }
   
   
   func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
      
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "extensionCell", for: indexPath) as! ABCell
      
      cell.label1.text = self.stationTimes[indexPath.row]
      
      
      
      return cell
   }
   
   
}

//
