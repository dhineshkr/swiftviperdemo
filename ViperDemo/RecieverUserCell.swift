//
//  NonCurrentUserCell.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit
import Foundation


class RecieverUserCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.setAsCircularImage()
        self.messageLabel.layer.cornerRadius = 10.0
        self.messageLabel.layer.masksToBounds = true
    }
    
    func initCellWithData(data: RecieverChatViewModel) {
        self.messageLabel.text = data.message
        if let url = NSURL(string: data.profileImage) {
            self.profileImage.kf_showIndicatorWhenLoading = true
            self.profileImage.kf_setImageWithURL(url)
        }
        //self.messageLabel.backgroundColor = data.bgColor
    }
    
}
