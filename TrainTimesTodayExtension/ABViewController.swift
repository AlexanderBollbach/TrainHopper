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
 
//   @IBOutlet weak var tableView: UITableView!

   let defaults = UserDefaults(suiteName: "group.AB.TrainTimesApp")!

   
   
   var fromStation: Station?
   var toStation: Station?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
//      dao.configureData()
      
      
      
//      let nibCell = UINib(nibName: "TripsCell", bundle: Bundle(identifier: "test.SharedCode"))
//      tableView.register(nibCell, forCellReuseIdentifier: "TripsCell")
//      
      
//      tableView.dataSource = tripsDataSource
      
  

      preferredContentSize = CGSize(width: 0, height: 600)
      
      
      
   }
   

   
   
 
   override func viewWillAppear(_ animated: Bool) {
 
//      dao.fetchTrips { (trips) in
//        
//         self.tripsDataSource.dataStore = trips
// 
//         let numTrips = trips?.count
//         let rowHeight = 44 // static
//         let h = numTrips! * rowHeight
//         
//         self.preferredContentSize = CGSize(width: 0, height: h)
// 
//         self.viewDidLayoutSubviews()
//         self.view.layoutIfNeeded()
//  
//      }
      
   }
   
   

//   override func viewDidLayoutSubviews() {
//      self.tableView.reloadData()
//   }
//   
//   
//
//   func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
//      completionHandler(NCUpdateResult.newData)
//   }
//   
//
//   func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
//      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//   }
//   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}


