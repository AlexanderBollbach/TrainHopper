//
//  PickStationViewController.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 8/3/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import UIKit



class PickStationViewController: UIViewController {
   
   
   @IBOutlet weak var searchField: UISearchBar!
   
   var stationList: [String]!
   
   var filteredStationList = [String]()
   
   var stationToPick: SelectedStationModel!
   
   @IBOutlet weak var tableview: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
      resetFilteredStationList()
      
      self.searchField.backgroundColor = UIColor.clear
      self.searchField.backgroundImage = UIImage()
      
      self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      
      
      
      
      let index = indexOfCurrentStation()
      let indexPath = IndexPath(row: index, section: 0)
      self.tableview.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: true)
   
   
   }
   
   
   
   func indexOfCurrentStation() -> Int {
      
      let idx = filteredStationList.index(of: stationToPick.stationName)!
      
      return idx
      
   }
   
   
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.searchField.resignFirstResponder()
   }
   
 
   
   func resetFilteredStationList() {
      filteredStationList.removeAll()
      filteredStationList.append(contentsOf: stationList)
   }
   
   
   
   @IBAction func tappedCancel(sender: AnyObject) {
      
      self.dismiss(animated: true, completion: nil)
   }
   
  

   
   
   func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
      
      let temp = self.stationList?.filter{ $0.ABHasPrefix(searchTerm: searchText) }
      
      if searchText == "" {
         resetFilteredStationList()
         self.tableview.reloadData()
         return
      }
      
      filteredStationList = temp!
      
      self.tableview.reloadData()
      
   }
   
   func searchBarCancelButtonClicked(searchBar: UISearchBar) {
      resetFilteredStationList()
      self.tableview.reloadData()
   }
   
   
   
   
   
}






extension PickStationViewController: UITableViewDelegate, UITableViewDataSource {
   
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return filteredStationList.count // ?? 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell: UITableViewCell = self.tableview.dequeueReusableCell(withIdentifier: "cell")!
      
      cell.textLabel?.text = filteredStationList[indexPath.row]
      
      return cell

   }
   
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      stationToPick.stationName = filteredStationList[indexPath.row]
      
      let presentingVC = self.presentingViewController as! MainController
      
      presentingVC.updateStationButtons()
      
      self.presentingViewController?.dismiss(animated: true, completion: nil)
   }
   
   
   
}









extension PickStationViewController: UIViewControllerTransitioningDelegate {
   
   func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      return PopAnimator()
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


