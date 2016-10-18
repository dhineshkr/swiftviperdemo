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
    
    private var presenter: Presenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initUI()
        self.presenter = Presenter(handler: self)
    }
    
    func initUI() {
//        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
//        self.profileImage.clipsToBounds = true
        self.profileImage.setAsCircularImage()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.showSpinner()
        self.presenter.initModels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateView(response: Mappable) {
        self.hideSpinner()
        if let chatThread = response as? ChatThreadModel {
            nameLabel.text = chatThread.name
            if let profile = chatThread.profile_img, url = NSURL(string: profile) {
                profileImage.kf_showIndicatorWhenLoading = true
                profileImage.kf_setImageWithURL(url)
            }
        }
    }
    
    func updateError(error: ErrorType?) {
        self.hideSpinner()
        print(error)
    }
        
}

