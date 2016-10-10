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
   
   
   let tripsDataSource = TripsDataSource()

   
   
   let dao = DAO.sharedInstance
   
   
   
   @IBOutlet weak var tableView: UITableView!

   let defaults = UserDefaults(suiteName: "group.AB.TrainTimesApp")!

   
   
   var fromStation: Station?
   var toStation: Station?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      dao.configureData()
      
      
      
      let nibCell = UINib(nibName: "TripsCell", bundle: Bundle(identifier: "test.SharedCode"))
      tableView.register(nibCell, forCellReuseIdentifier: "TripsCell")
      
      
      tableView.dataSource = tripsDataSource
      
      initData()
  

//      preferredContentSize = CGSize(width: 0, height: 600)
      
      
      
   }
   
   func initData() {
      
      
      
      if defaults.value(forKey: "fromStation") != nil {
         fromStation = NSKeyedUnarchiver.unarchiveObject(with: defaults.value(forKey: "fromStation") as! Data) as! Station!
      } else {
         fromStation = Station()
      }
      
      if defaults.value(forKey: "toStation") != nil {
         toStation = NSKeyedUnarchiver.unarchiveObject(with: defaults.value(forKey: "toStation") as! Data) as! Station!
      } else {
         toStation = Station()
      }
      
      
   }
   
   
   override func viewDidAppear(_ animated: Bool) {
      

      
      // get trips here
      
      
      dao.fetchTrips { (trips) in
         self.tripsDataSource.dataStore = trips
         self.tableView.reloadData()
      }
      
   }
   
   

   
   

   func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {

      
      
      completionHandler(NCUpdateResult.newData)
   }
   
   
   func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}


