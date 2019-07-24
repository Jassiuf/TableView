//
//  ChecklistItem.swift
//  Checklist
//
//  Created by sodhi on 6/19/18.
//

import Foundation

class ChecklistItem: NSObject {
  
  var name = ""
  var checked = false
  
  func toggleChecked() {
    checked = !checked
  }
}


