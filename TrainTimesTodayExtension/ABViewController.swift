//
//  ABViewController.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 7/23/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit
import NotificationCenter


class ABViewController: UIViewController {
   
   
   var stationsTableView: UITableView!
   
   var stationTimes = [String]()
   
   
   var lirrAPI: LIRR_API!
   
   var loadButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      lirrAPI = LIRR_API()
      
    
      
      
      
      
      
      preferredContentSize = CGSizeMake(0, 600)
      
      
      let tableviewFrame = CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 550)
      
      
      
      
      let buttonFrame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50)
      
      loadButton = UIButton(frame: buttonFrame)
      view.addSubview(loadButton)
      
      loadButton.setTitle("load", forState: .Normal)
      
      loadButton.addTarget(self, action: #selector(ABViewController.loadButtonPressed), forControlEvents: .TouchUpInside)

      
      stationsTableView = UITableView(frame: tableviewFrame, style: .Plain)
      view.addSubview(stationsTableView)
      
      stationsTableView.dataSource = self
      
      
      UIView.animateWithDuration(0.4, animations: {
         self.loadButton.backgroundColor = UIColor.purpleColor()
      }) { (true) in
         self.loadButton.backgroundColor = UIColor.clearColor()
      }
      
      
   }
   
   
   
   func loadButtonPressed() {
      
      updateStationTimes()
   }
   
   
   override func viewDidLayoutSubviews() {
      
      updateStationTimes()
   }
   
   
   
   
   func updateStationTimes() {
      
      
      let defaults = NSUserDefaults(suiteName: "group.AB.TrainTimesApp")!
      
      guard let homeStation = defaults.stringForKey("homeStation") else {
         return
      }
      
      guard let workStation = defaults.stringForKey("workStation") else {
         return
      }
      
      
      lirrAPI.homeStation = homeStation
      lirrAPI.workStation = workStation
      
      
      lirrAPI.httpGet { asdf in
         
         
         self.stationTimes = asdf
         
         
         self.stationsTableView.reloadData()
      }
      
      
   }
   
   func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
      // Perform any setup necessary in order to update the view.
      
      // If an error is encountered, use NCUpdateResult.Failed
      // If there's no update required, use NCUpdateResult.NoData
      // If there's an update, use NCUpdateResult.NewData
      
      updateStationTimes()
      
      completionHandler(NCUpdateResult.NewData)
   }
   
   
   func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
      return UIEdgeInsetsZero
   }
   
   
   
   
   override func viewDidAppear(animated: Bool) {
      
      
      updateStationTimes()
     
      
   }
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}



extension ABViewController: UITableViewDataSource {
   
   
   
   
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
   }
   
   
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return stationTimes.count
   }
   
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      
      let cell = ABCell(style: .Default, reuseIdentifier: "ABCellId")
      
      cell.textLabel?.text = self.stationTimes[indexPath.row]
      
      return cell
   }
   
   
}


