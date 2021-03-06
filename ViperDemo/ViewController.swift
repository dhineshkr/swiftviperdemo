//
//  ViewController.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import UIKit
import ObjectMapper
import Kingfisher

class ViewController: BaseViewController, PresenterDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var chatList: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var footerView: UIView!
    
    private var presenter: Presenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = Presenter(handler: self)
        // Do any additional setup after loading the view, typically from a nib.
        self.initUI()
        self.presenter.initViews(self.chatList)
    }
    
    func initUI() {
        self.profileImage.setAsCircularImage()
        self.chatList.estimatedRowHeight = 70
        self.chatList.rowHeight = UITableViewAutomaticDimension
        self.chatList.setNeedsLayout()
        self.chatList.layoutIfNeeded()
        
        self.footerView.layer.cornerRadius = self.footerView.frame.size.height / 2
        self.footerView.clipsToBounds = true
        self.footerView.layer.borderWidth = 2.0
        self.footerView.layer.borderColor = Utill.getColor(229, g: 229, b: 229).CGColor
        
        self.footerView.layer.masksToBounds = false
        self.footerView.layer.shadowOffset = CGSizeMake(2, 2)
        self.footerView.layer.shadowRadius = 1
        self.footerView.layer.shadowOpacity = 0.25
    }
    
    override func viewDidAppear(animated: Bool) {
        self.showSpinner()
        self.presenter.initModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView(response: AnyObject?) {
        self.hideSpinner()
        if let header = response as? ChatThreadHeaderViewModel {
            nameLabel.text = header.name
            if let profile = header.profileImage, url = NSURL(string: profile) {
                profileImage.kf_showIndicatorWhenLoading = true
                profileImage.kf_setImageWithURL(url)
            }
            self.dateLabel.text = header.dateStr
        } else {
            self.chatList.reloadData()
        }
        //refresh the whole view
    }
    
    func updateError(error: ErrorType?) {
        self.hideSpinner()
        print(error)
    }
        
}

