//
//  ABViewController.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 7/23/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit
import NotificationCenter
import SharedCode

class ABViewController: UIViewController {
   
   
   
   
   
   
   
   
//   var tripsDataSource: TripsDataSource?
   
   @IBOutlet weak var tableView: UITableView!

   let defaults = UserDefaults(suiteName: "group.AB.TrainTimesApp")!

   var tripsDataSource: TripsDataSource?
   
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      
      
      initData()
  

      preferredContentSize = CGSize(width: 0, height: 600)
      
      
      
   }
   
   func initData() {
      
      
//      
//      if defaults.value(forKey: "fromStation") != nil {
//         fromStation = NSKeyedUnarchiver.unarchiveObject(with: defaults.value(forKey: "fromStation") as! Data) as! StationModel!
//      } else {
//         fromStation = StationModel()
//      }
//      
//      if defaults.value(forKey: "toStation") != nil {
//         toStation = NSKeyedUnarchiver.unarchiveObject(with: defaults.value(forKey: "toStation") as! Data) as! StationModel!
//      } else {
//         toStation = StationModel()
//      }
//      
      
   }
   
   
   override func viewDidAppear(_ animated: Bool) {
      

      
      // get trips here
      
   }
   
   

   
   

   func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {

      
      
      completionHandler(NCUpdateResult.newData)
   }
   
   
   func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}


//
//extension ABViewController: UITableViewDataSource {
//   
//   
//   
//   
//   private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//      return 1
//   }
//   
//   
//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return stationTimes.count
//   }
//   
//   
//   
//   
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      
//      
//      let cell = tableView.dequeueReusableCell(withIdentifier: "extensionCell", for: indexPath) as! ABCell
//      
//      cell.label1.text = self.stationTimes[indexPath.row]
//      
//      
//      
//      return cell
//   }
//   
//   
//}

//
