//
//  Interactor.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

protocol InteractorDelegate : class {
    func responseOnSuccess(response:Mappable)
    func responseOnFailure(error: ErrorType?)
}

class ChatThreadModel : Mappable {
    var name:String?
    var profile_img:String?
    var time_str:String?
    var chats:[ChatMessageModel]
    
    func mapping(map: Map) {
        name <- map["name"]
        profile_img <- map["profile_img"]
        time_str <- map["time_str"]
        chats <- map["thread"]
    }
    
    required init?(_ map: Map) {
        //JSON validation comes here prior to object creation
        chats = []
        if map.JSONDictionary["name"] == nil ||  map.JSONDictionary["profile_img"] == nil ||
            map.JSONDictionary["time_str"] == nil {
            return nil
        }
    }
}

class ChatMessageModel : Mappable {
    var is_current_user:Bool?
    var type:String?
    var message:String?
    var url:String?
    var read:Bool?
    var received:Bool?
    
    func mapping(map: Map) {
        is_current_user <- map["is_current_user"]
        type <- map["type"]
        message <- map["message"]
        url <- map["url"]
        read <- map["read"]
        received <- map["received"]
    }
    
    required init?(_ map: Map) {
        //JSON validation comes here prior to object creation
        if map.JSONDictionary["is_current_user"] == nil ||
            map.JSONDictionary["type"] == nil {
            return nil
        }
    }
}

class Interactor {
    
    unowned var resultHandler: InteractorDelegate
    
    init(handler: InteractorDelegate) {
        self.resultHandler = handler
    }
    
    func getChatThread() {
        let URL = "http://f22labs.com/public/test/chat/chat.json"
        Alamofire.request(.GET, URL).responseObject { (
            response: Response<ChatThreadModel, NSError>) in
            
            if let chatThread = response.result.value {
                self.resultHandler.responseOnSuccess(chatThread)
            } else {
                self.resultHandler.responseOnFailure(response.result.error)
            }
        }
    }
    
}