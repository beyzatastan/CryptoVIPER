//
//  Presenter.swift
//  VIPERCrypto
//
//  Created by beyza nur on 31.01.2024.
//

import Foundation

// Class
// Protocol
// Talks To -> Interactor, Router, View
// Interactor needs to tell what kind of interaction happened so presenter needs to update the view
enum NetworkError:Error{
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter{
    var router:AnyRouter?{ get set }
    var view:AnyView?{get set}
    var interactor:AnyInteractor?{get set}
    
    //interactor veriyi indirdiğinde view a kendini güncellemesi için verilerin yeni halini göndericez Bu yüzden interactordan veri almamız lazım
    
    func interactorDidDowloadCrypto(result:Result<[Crypto],Error>)
    
}

class CryptoPresenter:AnyPresenter{
    var router: AnyRouter?
    
    var view: AnyView?
    
    //interactor ve presenter birbirine bağlandığında bu fonksioynu çalıştır
    var interactor: AnyInteractor? {
        didSet{
            interactor?.dowloadCryptos()
        }
    }
    
    
    func interactorDidDowloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Try again later")
        }
    }
    

    
    
}

