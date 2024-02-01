//
//  Route.swift
//  VIPERCrypto
//
//  Created by beyza nur on 31.01.2024.
//

import Foundation
import UIKit

//bağlama işleri
//entrypoint:bir UIVİEW aslında

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter{
    var entry :EntryPoint? {get}
    //her seyi bağlayacğımız fonksiyon
    static func startExecution()->AnyRouter
}
class CryptoRouter:AnyRouter{
    var entry: EntryPoint?
    
    
    static func startExecution() -> AnyRouter {
        
        let router=CryptoRouter()
        
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter=presenter
        
        presenter.view=view
        presenter.router=router
        presenter.interactor=interactor
        
        interactor.presenter=presenter
        
        router.entry=view as? EntryPoint
        
        return router
    }
    
}
