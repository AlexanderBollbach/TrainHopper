//
//  ViewController.swift
//  TestAppExtension
//
//  Created by alexanderbollbach on 7/10/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit
import MapKit
import SharedCode
import Presentr





class MainController: UIViewController {
   
   
   
   
   let dao = DAO.sharedInstance

   @IBOutlet weak var tripsTableView: UITableView!
   let presenter: Presentr = {
      let presenter = Presentr(presentationType: .popup)
      presenter.transitionType = .coverVertical // Optional
      return presenter
   }()
   
   @IBOutlet weak var departingButton: StationButton!
   @IBOutlet weak var arrivingButton: StationButton!
   
   
   let tripsDataSource: TripsDataSource = TripsDataSource()

   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      let nibCell = UINib(nibName: "TripsCell", bundle: Bundle(identifier: "test.SharedCode"))
      tripsTableView.register(nibCell, forCellReuseIdentifier: "TripsCell")
      
      self.tripsTableView.dataSource = tripsDataSource
      
      DAO.sharedInstance.configureData()

      self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
      self.navigationController?.navigationBar.shadowImage = UIImage()
      self.navigationController?.navigationBar.isTranslucent = true

      self.navigationController?.navigationBar.tintColor = .blue
//      self.navigationController?.navigationBar.topItem?.title = "Pick Stations";

   }

   
   
   
   
   
   
   func updateUI() {
      
      departingButton.name.text = dao.getFromStation().name
      arrivingButton.name.text = dao.getToStation().name
      

      fetchTrips()

      
      
   }
   
   
   
   func fetchTrips() {
      
      
      DAO.sharedInstance.fetchTrips { (trips) in
         self.tripsDataSource.dataStore = trips
         self.tripsTableView.reloadData()
      }
   }
   

   
   

   
   
   @IBAction func toStationTapped(_ sender: StationButton) {
      
      var stationType: StationType?
      
      if sender == departingButton {
         stationType = .departing
      } else if sender == arrivingButton {
         stationType = .arriving
      }
      
      tappedStationButton(withType: stationType!)
   }
   
   @IBAction func fromStationTapped(_ sender: StationButton) {
      
      
      var stationType: StationType?
      
      if sender == departingButton {
         stationType = .departing
      } else if sender == arrivingButton {
         stationType = .arriving
      }
      
      tappedStationButton(withType: stationType!)
   }
   
   
   
   func tappedStationButton(withType type: StationType) {
      
      let pickerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickStation") as! PickStationViewController
      
      pickerVC.stationType = type
      pickerVC.delegate = self
      
      customPresentViewController(presenter, viewController: pickerVC, animated: true, completion: nil)
   }


   
}







extension MainController: PickStationDelegate {
 
   
   
   func didTapOnStation(station: Station, stationType: StationType) {
      
      
      
      dao.setStation(active: stationType, station: station)
      
      updateUI()
   }
}




