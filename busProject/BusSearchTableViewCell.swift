//
//  BusSearchTableViewCell.swift
//  busProject
//
//  Created by kwon on 16/08/2017.
//  Copyright © 2017 kwon. All rights reserved.
//

import UIKit

class BusSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lbBusNum: UILabel!
    
    @IBOutlet weak var lbBusPoint: UILabel!
    
    @IBOutlet weak var lbBusEct: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
