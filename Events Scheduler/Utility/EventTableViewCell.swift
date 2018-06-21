//
//  EventTableViewCell.swift
//  Events Scheduler
//
//  Created by Gourav  Garg on 21/06/18.
//  Copyright © 2018 Gourav  Garg. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFirstStudent: UIImageView!
    @IBOutlet weak var imageSecondStudent: UIImageView!
    @IBOutlet weak var imageThirdStudent: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
