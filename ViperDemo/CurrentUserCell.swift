//
//  CurrentUserCell.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit


class CurrentUserCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var sentImage: UIImageView!
    @IBOutlet weak var readImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sentImage.setAsCircularImage()
        readImage.setAsCircularImage()
    }
}
