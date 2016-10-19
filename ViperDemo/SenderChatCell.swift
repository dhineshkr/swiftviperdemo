//
//  CurrentUserCell.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit


class SenderChatCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var recievedImage: UIImageView!
    @IBOutlet weak var readImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recievedImage.setAsCircularImage()
        readImage.setAsCircularImage()
        self.messageLabel.layer.cornerRadius = 10.0
        self.messageLabel.layer.masksToBounds = true
    }
    
    func initCellWithData(data: SenderChatViewModel) {
        self.messageLabel.text = data.message
        if let image = data.recieved {
            self.recievedImage.hidden = false
            self.recievedImage.image = UIImage(named: image)
        } else {
            self.recievedImage.hidden = true
        }
        if let image = data.read {
            self.readImage.hidden = false
            self.readImage.image = UIImage(named: image)
        } else {
            self.readImage.hidden = true
        }
        //self.messageLabel.backgroundColor = data.bgColor
    }
}
