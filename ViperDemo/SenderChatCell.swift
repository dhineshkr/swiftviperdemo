//
//  CurrentUserCell.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit


class SenderChatCell: UITableViewCell {
    
    @IBOutlet weak var textContent: UITextView!
    @IBOutlet weak var recievedImage: UIImageView!
    @IBOutlet weak var readImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recievedImage.setAsCircularImage()
        readImage.setAsCircularImage()
        self.textContent.layer.cornerRadius = 15.0
        self.textContent.layer.masksToBounds = true
        self.textContent.font = UIFont.systemFontOfSize(20.0)
    }
    
    func setHTMLtext(text: String) {
        let attributedString = try! NSMutableAttributedString(
            data: text.dataUsingEncoding(NSUnicodeStringEncoding)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        attributedString.addAttributes(
            [NSForegroundColorAttributeName: UIColor.whiteColor()],
            range: NSMakeRange(0, attributedString.length))
        self.textContent.textContainerInset = UIEdgeInsetsMake(10, 10, -30, 10)
        self.textContent.attributedText = attributedString
    }
    
    func setContent(type: String, text: String) {
        if type.lowercaseString == "html".lowercaseString {
            self.setHTMLtext(text)
        } else {
            self.textContent.text = text
        }
    }
    
    func initCellWithData(data: SenderChatViewModel) {
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
        if let type = data.type {
            self.setContent(type, text: data.message)
        }
    }
}
