//
//  NewsCell.swift
//  Sjmo
//
//  Created by Interview on 5/14/15.
//  Copyright (c) 2015 Altimetrik. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
