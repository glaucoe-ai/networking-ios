//
//  Interactor.swift
//  Networking
//
//  Created by Glauco Moraes on 24/11/20.
//

import Foundation

class Interactor {
    
    private var networkManager: AnyNetworkManager<URLSession>?
    
    convenience init() {
        self.init(networkManager: NetworkManager<URLSession>() )
    }
    
    required init<T: NetworkManagerProtocol>(networkManager: T) {
        self.networkManager = AnyNetworkManager(manager: networkManager)
    }
    
    func getData() {
        if let url = URL(string: "") {
            self.networkManager?.fetch(url: url, method: .get, completionBlock: { result in
                switch result {
                case .failure(let error):
                    print (error)
                case .success(let data):
                    let decoder = JSONDecoder()
                    let decoded = try! decoder.decode([Photo].self, from: data)
                    print(decoded)
                }
            })
        }
    }
}
