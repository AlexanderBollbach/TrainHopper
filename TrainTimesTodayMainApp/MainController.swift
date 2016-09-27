//
//  ViewController.swift
//  TestAppExtension
//
//  Created by alexanderbollbach on 7/10/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit




class MainController: UIViewController {
   
   
   
   
   @IBOutlet weak var fromStationButton: ABCustomButton1!
   @IBOutlet weak var toStationButton: ABCustomButton1!
   let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
   let dao = DAO.sharedInstance
   
   
   var activeButton: ABCustomButton1?
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      dao.configureData()
      
      self.updateStationButtons()
      
      
   }
   
   
   
   
   
   // Actions
   
   @IBAction func fromStationButtonTapped(sender: ABCustomButton1) {
      
      activeButton = sender
      launchPopUp(station: dao.fromStation)
   }
   
   @IBAction func toStationButtonTapped(sender: ABCustomButton1) {
      
      activeButton = sender
      launchPopUp(station: dao.toStation)
   }
   
   
   
   func launchPopUp(station: SelectedStationModel) {
      
      let vc = storyBoard.instantiateViewController(withIdentifier: "PickStation") as! PickStationViewController
      
      vc.modalPresentationStyle = .overCurrentContext
      
      vc.transitioningDelegate = self
      
      vc.stationToPick = station
      
      let stationList = dao.getStationList()
      
      vc.stationList = stationList
      
      self.present(vc, animated: true, completion: nil)
      
   }
   
   
   
   
   
   
   
   func updateStationButtons() {
      
      //      self.fromStationButton.setStationLabel(dao.fromStation.stationName)
      //      self.toStationButton.setStationLabel(dao.toStation.stationName)
      
   }
   
   
   
}










// Transition

extension MainController: UIViewControllerTransitioningDelegate {
   
   func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) ->
      UIViewControllerAnimatedTransitioning? {
         return PushAnimator()
   }
   
   func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return PopAnimator()
   }
}










