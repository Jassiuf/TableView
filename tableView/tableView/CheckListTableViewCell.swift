//
//  ChecklistItem.swift
//  tableView
//
//  Created by Sodhi, Jaswinder on 7/22/19.
//  Copyright © 2019 Sodhi, Jaswinder. All rights reserved.
//

import Foundation

class CheckListTableViewCell: NSObject {

    var name = ""
    var checked = false

    func toggleCheckmark() {
        checked = !checked
    }
}
