//
//  ChecklistItemTableViewCell.swift
//  tableView
//
//  Created by Sodhi, Jaswinder on 7/24/19.
//  Copyright © 2019 Sodhi, Jaswinder. All rights reserved.
//

import UIKit

class ChecklistItemTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkmarkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
