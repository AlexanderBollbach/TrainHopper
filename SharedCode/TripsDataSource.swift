
import UIKit


public class TripsDataSource: NSObject, UITableViewDataSource {
   
   
   public var dataStore: [Trip]?
   

   
   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataStore?.count ?? 0
   }
   

   
   
   
   public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      
      let trip = dataStore?[indexPath.row]
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "TripsCell", for: indexPath) as! TripsCell
      
      
      cell.departingLabel.text = trip?.getDepartureTime()
      cell.arrivingLabel.text = trip?.getArrivalTime()
      
      return cell
   }

}
