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
   
   
   @IBOutlet weak var mapView: MKMapView!
   
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
      
//      self.updateStationButtons()
      
      
      
      
      
   }
   
   override func viewDidAppear(_ animated: Bool) {
      applyMask()
   }
   
   func applyMask() {
      
      
      let gradientLayer = CAGradientLayer()
      
      gradientLayer.frame = self.view.bounds
//      gradientLayer.locations = [0.0, 0.1, 0.8, 1.0]
      gradientLayer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
      gradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
//      self.view.layer.insertSublayer(gradientLayer, above: self.mapView.layer)
      self.mapView.layer.insertSublayer(gradientLayer, above: self.mapView.layer)
      
      
   }
   
   
   
   
   // Actions
   
   @IBAction func fromStationButtonTapped(sender: StationButton) {
      
      activeButton = sender
      launchPopUp(station: dao.fromStation)
   }
   
   
   
   
   
   func launchPopUp(station: StationModel?) {
      
      let vc = storyBoard.instantiateViewController(withIdentifier: "PickStation") as! PickStationViewController
      
      vc.modalPresentationStyle = .overCurrentContext
      
      vc.transitioningDelegate = self
      
      vc.stationToPick = station
      
      let stationList = dao.getStationList()
      
      vc.stationList = stationList
      
      self.present(vc, animated: true, completion: nil)
      
   }
   
   
   
   
   
   
   
   
   
   
   
   
   func updateStationButtons() {
      
      self.fromStationButton.setTitle(dao.fromStation.name, for: .normal)
      
      let coord = CLLocationCoordinate2DMake(Double(dao.fromStation.lat), Double(dao.fromStation.long))
      let span1 =  MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
      let region = MKCoordinateRegion(center: coord, span: span1)
      self.mapView.setRegion(region, animated: true)
      
      
      
      let point = self.mapView.convert(coord, toPointTo: self.view)
      
      
      let layer = CAShapeLayer()
      layer.path = UIBezierPath(rect: CGRect(origin: point, size: CGSize(width: 10, height: 10))).cgPath
      layer.fillColor = UIColor.red.cgColor
      
      self.view.layer.addSublayer(layer)
      
      
//
      
      
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












