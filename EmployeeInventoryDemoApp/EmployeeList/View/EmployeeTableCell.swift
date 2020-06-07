//
//  EmployeeTableCell.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 20/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class EmployeeTableCell: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var labelEmployeeID: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDesignation: UILabel!
    @IBOutlet weak var labelCompetency: UILabel!
    @IBOutlet weak var labelProject: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backGroundView.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
