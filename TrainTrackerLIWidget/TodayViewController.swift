//
//  TodayViewController.swift
//  TrainTrackerLIWidget
//
//  Created by alexanderbollbach on 10/14/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit
import NotificationCenter

import SharedCode

class TodayViewController: UIViewController, NCWidgetProviding {
   
   @IBOutlet weak var tableview: UITableView!
   @IBOutlet weak var countdownView: CountdownView!
   let dao = DAO.sharedInstance
   
   var time: String!
   
   var dataSource = TripsDataSource()
   
   
   func backButtonTapped() {
      
      dismissCountdown()
      DAO.sharedInstance.inCountDownMode = false
   }
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      countdownView.backButton.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
      
      
      
      
      countdownView.isHidden = true
      
      tableview.dataSource = dataSource
      
      
      time = dao.getDepartureTime()
      
      let nibCell = UINib(nibName: "TripsCell", bundle: Bundle(identifier: "test.SharedCode"))
      tableview.register(nibCell, forCellReuseIdentifier: "TripsCell")
      
      dao.configureData()
      
      
      self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
      
      
      DAO.sharedInstance.fetchTrips { (trips) in
         self.dataSource.dataStore = trips
         self.tableview.reloadData()
      }
      
   }
   

   private func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {

      completionHandler(NCUpdateResult.newData)
   }
   
   override func viewWillAppear(_ animated: Bool) {

      if DAO.sharedInstance.inCountDownMode {
         showCountdown()
      } else {
         dismissCountdown()
      }
   }
   
   
   func showCountdown() {
      
      tableview.isHidden = true
      countdownView.isHidden = false
      
      Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
         self.countdownView.countDownLabel.text = Utilities.printTime(with: self.time)
         }.fire()
      
   }
   
   func dismissCountdown() {
      
      tableview.isHidden = false
      countdownView.isHidden = true
   }
   
   func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
      if (activeDisplayMode == NCWidgetDisplayMode.compact) {
         self.preferredContentSize = maxSize
      }
      else {
         self.preferredContentSize = CGSize(width: maxSize.width, height: tableview.contentSize.height)
      }
   }
   
}




extension TodayViewController : UITableViewDelegate {
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      

      
      let trip = dataSource.dataStore![indexPath.row]
      
      let thisDepartureTime = trip.getFirstStopTime()
      
     
      
      dao.setDepartureTime(time: thisDepartureTime)
      
      DAO.sharedInstance.inCountDownMode = true
      
      time = dao.getDepartureTime()
      showCountdown()
      
   }
   
   
}
