//
//  MapVC.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 10/4/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
import UIKit
import MapKit

import SharedCode

class MapVC: UIViewController {
   
   
   let dao = DAO.sharedInstance
   
   @IBOutlet weak var mapView: MKMapView!
   
   
   
   override func viewDidLoad() {
      

      
   }
   
   
   
   override func viewWillAppear(_ animated: Bool) {
 

      let fromStation = dao.getFromStation()
      let toStation = dao.getToStation()
      
      let fromStationCoor = fromStation.coordinate
      let toStationCoor = toStation.coordinate
//
//      
//      // anotations
//      
      mapView.removeAnnotations(mapView.annotations)

      let from = MKPointAnnotation()
      from.coordinate = fromStationCoor
      from.title = "From"
      mapView.addAnnotation(from)
      
      let to = MKPointAnnotation()
      to.coordinate = toStationCoor
      to.title = "to"
      mapView.addAnnotation(to)

      
      
      if let stops = dao.getCurrentTripsStops() {
      
         createRouteWithStops(stops: stops)
      }
   
      
      

      mapView.showAnnotations(mapView.annotations, animated: true)
//
      
   }
   
   
   func addAnotationsFromCoordList(coords: [CLLocationCoordinate2D]) {
      
      
      for coord in coords {
         
         
         let to = MKPointAnnotation()
         to.coordinate = coord
         mapView.addAnnotation(to)
         
      }
      
   }
   
   
   
   func createRouteWithStops(stops: [Stop]) {
      
      guard let coordinates = dao.getCoordinateList() else {
         return
      }
      
    
      
      addAnotationsFromCoordList(coords: coordinates)
      
      
      
      
      

      let geodesicPolyline = MKGeodesicPolyline(coordinates: coordinates, count: coordinates.count)
//
//      
      self.mapView.add(geodesicPolyline)
//
      
      
      
   }
   
   
   
   func setRegion(with coor: CLLocationCoordinate2D) {
      
//      let data = DAO.sharedInstance
//      
//      let locations = [data.fromStation.coordinate, data.toStation.coordinate]
//      
//      let centerPoint = getMiddlePoint(locations: locations)
//      
//      let region = MKCoordinateRegion(center: centerPoint, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//      self.mapView.setRegion(region, animated: true)
//      
   }
   
   
   
   
   
   
   
   
   
   
   
   
   func getMiddlePoint(locations: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D {
      
      
      //find rect that encloses all coords
      
      var maxLat = Double(-200)
      var maxLong = Double(-200)
      var minLat = Double(MAXFLOAT)
      var minLong = Double(MAXFLOAT)
      
      for location in locations {
         
         
         
         if location.latitude < minLat {
            minLat = location.latitude;
         }
         
         if (location.longitude < minLong) {
            minLong = location.longitude;
         }
         
         if (location.latitude > maxLat) {
            maxLat = location.latitude;
         }
         
         if (location.longitude > maxLong) {
            maxLong = location.longitude;
         }
      }
      
      //Center point
      
      let center = CLLocationCoordinate2D(latitude: (maxLat + minLat) * 0.5, longitude: (maxLong + minLong) * 0.5);
      
      return center
      
      
   }
   
   
}   
   
   
   
   
   
   
   extension MapVC: MKMapViewDelegate {
      
      
      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         
         
         guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer()
         }
         
         let renderer = MKPolylineRenderer(polyline: polyline)
         renderer.lineWidth = 3.0
         renderer.alpha = 0.5
         renderer.strokeColor = UIColor.blue
         
         return renderer
      }
      
      

   
      
   }
   
   



