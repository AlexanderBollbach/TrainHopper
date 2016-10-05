//
//  PickStationViewController.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 8/3/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit
import SharedCode





protocol PickStationDelegate {
   
   func didTapOnStation(station: Station, stationType: StationType)
   
}



class PickStationViewController: UIViewController {
   
   
   
   var delegate: PickStationDelegate?
   
   let dao = DAO.sharedInstance
   
   
   @IBOutlet weak var searchField: UISearchBar!
   
   var stationList: [Station]?
   
   
   var stationType: StationType?
   
   
   var filteredStationList: [Station]?
   
   @IBOutlet weak var tableview: UITableView!
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      stationList = dao.getStations()
      
      filteredStationList = stationList
      
      self.searchField.backgroundColor = UIColor.clear
      self.searchField.backgroundImage = UIImage()
      
   }
   
   
   

   
   
   
   
   
   
   
   
   
   
}




extension PickStationViewController: UISearchBarDelegate {
   

   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      
      filteredStationList = stationList
      self.tableview.reloadData()
      
   }
   
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
      filteredStationList = self.stationList?.filter { $0.name.ABHasPrefix(searchTerm: searchText) }
      self.tableview.reloadData()
      
   }
   
}




extension PickStationViewController: UITableViewDelegate, UITableViewDataSource {
   
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return filteredStationList?.count ?? 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell: StationCell = self.tableview.dequeueReusableCell(withIdentifier: "stationCell")! as! StationCell
      
      cell.stationName.text = filteredStationList?[indexPath.row].name
      
      return cell
      
   }
   
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      
      let chosenStation = filteredStationList?[indexPath.row]
      
      
      delegate?.didTapOnStation(station: chosenStation!, stationType: stationType!)
      
      dismiss(animated: true, completion: nil)
   }
   
   
   
   
   
}












extension String {
   
   func ABHasPrefix(searchTerm: String) -> Bool {
      
      let lowerSearch = searchTerm.lowercased()
      let lowerSelf = self.lowercased()
      
      if lowerSelf.hasPrefix(lowerSearch) {
         return true
      } else {
         return false
      }
   }
}











