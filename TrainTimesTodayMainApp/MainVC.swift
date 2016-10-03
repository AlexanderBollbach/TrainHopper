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

class MainController: UIViewController {
   

   
   @IBOutlet weak var departingButton: StationButton!
   @IBOutlet weak var arrivingButton: StationButton!

   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      DAO.sharedInstance.configureData()
      
      
  
      
      self.departingButton.stationType = .departing
      self.arrivingButton.stationType = .arriving
      
      
   }
   

   
   override func viewWillAppear(_ animated: Bool) {
      updateUI()
   }
   
   
   
   func updateUI() {
  
      self.departingButton.name.text = DAO.sharedInstance.fromStation.name
      self.arrivingButton.name.text = DAO.sharedInstance.toStation.name
   }
   
   
   

   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      guard let button = sender as? StationButton else {
         return
      }
      
      DAO.sharedInstance.activeStation = button.stationType
   }

   
}




// Transition

extension MainController: UIViewControllerTransitioningDelegate {
   
   
   func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return PushAnimator()
   }
   
   
   
   func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return PopAnimator()
   }
   
   
}







