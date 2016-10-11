
import UIKit


public class TripsDataSource: NSObject, UITableViewDataSource {
   
   public var dataStore: [Trip]?
   
   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      let count = dataStore?.count
      return count ?? 0
   }
   
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "TripsCell", for: indexPath) as! TripsCell
    
      let trip = dataStore?[indexPath.row]
      
      cell.departing.text = trip?.stops.first!.time
      cell.arriving.text = trip?.stops.last!.time

      cell.backgroundColor = .clear
//      cell.backgroundView?.backgroundColor = .clear
      
      return cell
   }

}
