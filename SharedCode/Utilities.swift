//
//  Utilities.swift
//  TrainTimesToday
//
//  Created by alexanderbollbach on 10/8/16.
//  Copyright © 2016 alexanderbollbach. All rights reserved.
//

import Foundation
class Utilities {
   
   
   
   class func keyExists(defaults: UserDefaults, key: String) -> Bool {
      return defaults.object(forKey: key) != nil
   }
   
}
