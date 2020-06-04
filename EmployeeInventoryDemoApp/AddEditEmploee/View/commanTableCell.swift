//
//  commanTableCell.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 03/06/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class commanTableCell: UITableViewCell {
    @IBOutlet weak var radioButtonImage: UIImageView!
    @IBOutlet weak var commanTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
