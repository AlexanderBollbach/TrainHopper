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
   

   @IBOutlet weak var tripsTableView: UITableView!
   let presenter: Presentr = {
      let presenter = Presentr(presentationType: .popup)
      presenter.transitionType = .coverVertical // Optional
      return presenter
   }()
   
   @IBOutlet weak var departingButton: StationButton!
   @IBOutlet weak var arrivingButton: StationButton!
   
   
   let tripsDataSource = TripsDataSource()

   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      self.tripsTableView.dataSource = tripsDataSource
      
      DAO.sharedInstance.configureData()

      self.departingButton.stationType = .departing
      self.arrivingButton.stationType = .arriving
      
      
      self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
      self.navigationController?.navigationBar.shadowImage = UIImage()
      self.navigationController?.navigationBar.isTranslucent = true
      
      
      
      self.navigationController?.navigationBar.topItem?.title = "Pick Stations";

   }

   
   override func viewWillAppear(_ animated: Bool) {
      updateUI()
      
      
   }
   
   
   func fetchTrips() {
      
      Service_API.httpGetStationTimes(from: DAO.sharedInstance.fromStation.abbr, to: DAO.sharedInstance.toStation.abbr) { (trips) in
         
         
         self.tripsDataSource.dataStore = trips
         
         self.tripsTableView.reloadData()
      }
      
      
      
   }
   
   
   func updateUI() {
  
      self.departingButton.name.text = DAO.sharedInstance.fromStation.name
      self.arrivingButton.name.text = DAO.sharedInstance.toStation.name
      
      fetchTrips()
   }
   
   
   @IBAction func toStationTapped(_ sender: StationButton) {
      
      tappedStationButton(withType: sender.stationType)
   }
   
   @IBAction func fromStationTapped(_ sender: StationButton) {
      
      tappedStationButton(withType: sender.stationType)
   }
   
   
   
   func tappedStationButton(withType type: ActiveStation) {
      
      let pickerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickStation") as! PickStationViewController
      
      pickerVC.delegate = self
      
      DAO.sharedInstance.activeStation = type
      
      customPresentViewController(presenter, viewController: pickerVC, animated: true, completion: nil)
      
   }


   
}






extension MainController: StationHandler {
   
   
   
   func didPickStation(station: StationModel) {
      DAO.sharedInstance.setActiveStation(station: station)
      updateUI()
   }
   
}

