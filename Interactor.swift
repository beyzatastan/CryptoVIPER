//
//  Interactor.swift
//  VIPERCrypto
//
//  Created by beyza nur on 31.01.2024.
//

import Foundation
import UIKit
// Class
// Protocol
// Talks To -> Presenter
// No completion handlers in interactor. It will inform the presenter once it happens.


protocol AnyInteractor{
    var presenter : AnyPresenter? {get set}
    
    func dowloadCryptos()
}

class CryptoInteractor : AnyInteractor{
    var presenter: AnyPresenter?
 
    func dowloadCryptos() {
        guard let url=URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json")
        else{return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidDowloadCrypto(result: .failure(NetworkError.NetworkFailed))
                return  }
            do {
                //bize veriler dizi içinde geldiği için Crypto yu dizi içinde yazıyoruz
                let cryptos=try JSONDecoder().decode([Crypto].self,from: data)
                self?.presenter?.interactorDidDowloadCrypto(result: .success(cryptos))
                
            } catch {
                self?.presenter?.interactorDidDowloadCrypto(result: .failure(NetworkError.ParsingFailed))

            }
            
        }
        task.resume()
    }
    
}
