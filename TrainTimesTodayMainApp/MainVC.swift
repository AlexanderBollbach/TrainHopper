//
//  ViewController.swift
//  TestAppExtension
//
//  Created by alexanderbollbach on 7/10/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit

import MapKit


class MainController: UIViewController {
   
   
   
   
   
   
   @IBOutlet weak var departingButton: StationButton!
   
   @IBOutlet weak var arrivingButton: StationButton!
   
//   let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
   let dao = DAO.sharedInstance
   
   
   
//   var activeButton: StationButton?
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      dao.configureData()
      
      
      
      self.departingButton.stationType = .departing
      self.arrivingButton.stationType = .arriving
      
      
   }
   
   
   
   override func viewWillAppear(_ animated: Bool) {
      updateUI()
   }
   
   
   
   func updateUI() {
      
      
      
      self.departingButton.name.text = dao.fromStation.name
      self.arrivingButton.name.text = dao.toStation.name
   }
   
   
   
   
   
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      
      
         
            
            guard let button = sender as? StationButton else {
               return
            }

            
            
               dao.activeStation = button.stationType
      
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








// extension stuff

extension MainController {
   
   
   func updateStationButtons() {
      //
      //      self.fromStationButton.setTitle(dao.fromStation.name, for: .normal)
      //
      //      let coord = CLLocationCoordinate2DMake(Double(dao.fromStation.lat), Double(dao.fromStation.long))
      //      let span1 =  MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
      //      let region = MKCoordinateRegion(center: coord, span: span1)
      //      self.mapView.setRegion(region, animated: true)
      //
      //
      //
      //      let point = self.mapView.convert(coord, toPointTo: self.view)
      //
      //
      //      let layer = CAShapeLayer()
      //      layer.path = UIBezierPath(rect: CGRect(origin: point, size: CGSize(width: 10, height: 10))).cgPath
      //      layer.fillColor = UIColor.red.cgColor
      //      
      //      self.view.layer.addSublayer(layer)
      
      
      //
      
      
   }
   
}




