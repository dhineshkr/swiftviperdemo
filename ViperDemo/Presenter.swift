//
//  Presenter.swift
//  ViperDemo
//
//  Created by Dhineshkumar_r on 10/18/16.
//  Copyright © 2016 Dhineshkumar_r. All rights reserved.
//

import ObjectMapper
import Foundation

protocol PresenterDelegate : class {
    func updateView(viewData: Mappable)
    func updateError(errorData: ErrorType?)
}


class Presenter : InteractorDelegate {
    
    private var interactor: Interactor!
    unowned var viewHandler: PresenterDelegate
    
    init(handler: PresenterDelegate) {
        self.viewHandler = handler
        self.interactor = Interactor(handler: self)
    }
    
    func initModels() {
        self.interactor.getChatThread()
    }
    
    func responseOnSuccess(response:Mappable) {
        self.viewHandler.updateView(response)
    }
    
    func responseOnFailure(error: ErrorType?) {
        self.viewHandler.updateError(error)
    }
    
}