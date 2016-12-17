//
//  Presenter.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import ObjectMapper
import Foundation
import UIKit

protocol PresenterDelegate : class {
    func updateView(viewData: AnyObject?)
    func updateError(errorData: ErrorType?)
}

class RecieverChatViewModel {
    var message: String
    var profileImage: String
    var bgColor: UIColor
    init(msg: String, profile: String, color: UIColor) {
        self.message = msg
        self.profileImage = profile
        self.bgColor = color
    }
}

class SenderChatViewModel {
    var message: String
    var recieved: String?
    var read: String?
    var bgColor: UIColor
    var type: String?
    init(msg: String, color: UIColor) {
        self.message = msg
        self.bgColor = color
    }
}

class ChatThreadHeaderViewModel {
    var name: String?
    var profileImage: String?
    var dateStr: String?
}


class Presenter : NSObject, UITableViewDataSource, InteractorDelegate {
    
    private var headerVM: ChatThreadHeaderViewModel
    private var messagesVM: [AnyObject]
    private var interactor: Interactor!
    unowned var viewHandler: PresenterDelegate
    
    init(handler: PresenterDelegate) {
        self.headerVM = ChatThreadHeaderViewModel()
        self.messagesVM = [AnyObject]()
        self.viewHandler = handler
        super.init()
        self.interactor = Interactor(handler: self)
    }
    
    func initViews(tableView: UITableView) {
        tableView.dataSource = self
    }
    
    func initModels() {
        self.interactor.getChatThread()
    }
    
    //Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesVM.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let chat = self.messagesVM[indexPath.row]
        if let recieverChatVM = chat as? RecieverChatViewModel {
            let userCell = tableView.dequeueReusableCellWithIdentifier(
                "reciever_user_cell")as? RecieverUserCell
            userCell?.initCellWithData(recieverChatVM)
            return userCell!
        } else {
            let userCell = tableView.dequeueReusableCellWithIdentifier(
                "sender_chat_cell")as? SenderChatCell
            if let senderChatVM = chat as? SenderChatViewModel {
                userCell?.initCellWithData(senderChatVM)
            }
            return userCell!
        }
    }
    
    func updateViewData(chatThread: ChatThreadModel) {
        self.headerVM = ChatThreadHeaderViewModel()
        self.headerVM.name = chatThread.name
        self.headerVM.profileImage = chatThread.profile_img
        self.headerVM.dateStr = chatThread.time_str?.uppercaseString
        messagesVM = [AnyObject]()
        for chat in chatThread.chats {
            if chat.is_current_user == true {
                if let msg = chat.message {
                    let sentChat = SenderChatViewModel(msg: msg, color: UIColor.grayColor())
                    if let boolStr = chat.read where boolStr == "true" {
                        sentChat.read = "checkboxSelected"
                    }
                    if let boolStr = chat.received where boolStr == "true" {
                        sentChat.recieved = "checkboxSelected"
                    }
                    sentChat.type = chat.type
                    messagesVM.append(sentChat)
                }
            } else {
                if let msg = chat.message, image = chatThread.profile_img {
                    messagesVM.append(RecieverChatViewModel(msg: msg, profile: image,
                        color: UIColor.yellowColor()))
                }
            }
        }
    }
    
    func responseOnSuccess(response:Mappable) {
        if let chatThread = response as? ChatThreadModel {
            self.updateViewData(chatThread)
        }
        self.viewHandler.updateView(self.headerVM)
        self.viewHandler.updateView(nil)
    }
    
    func responseOnFailure(error: ErrorType?) {
        self.viewHandler.updateError(error)
    }
    
}


