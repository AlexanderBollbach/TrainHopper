//
//  ViewController.swift
//  TestAppExtension
//
//  Created by alexanderbollbach on 7/10/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit




class MainController: UIViewController {
   
   
   
   var transferLayer: CAShapeLayer?
   
   @IBOutlet weak var fromStationButton: StationButton!
   
   
   let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
   let dao = DAO.sharedInstance
   
   var savedButtonFrame: CGRect?
   var tempConstraints: [NSLayoutConstraint]?
   var tempLayer: CAShapeLayer!
   
   
   var activeButton: StationButton?
   
   var transitionLayer: CAShapeLayer?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      dao.configureData()
      
      self.updateStationButtons()
      
      
      
      
      
   }
   
   
   
   
   // Actions
   
   @IBAction func fromStationButtonTapped(sender: StationButton) {
      
      activeButton = sender
      launchPopUp(station: dao.fromStation)
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
      
      self.fromStationButton.setTitle(dao.fromStation.stationName, for: .normal)
      //      self.toStationButton.setTitle(dao.toStation.stationName, for: .normal)
      
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












