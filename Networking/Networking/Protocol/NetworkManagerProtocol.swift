//
//  NetworkManagerProtocol.swift
//  Networking
//
//  Created by Glauco Moraes on 24/11/20.
//

import Foundation

public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }
    func cancel()
    func fetch(url: URL,
               method: HTTPMethod,
               headers: [String : String],
               token: String?,
               data: [String: Any]?,
               completionBlock: @escaping (Result<Data, Error>) -> Void)
}

public extension NetworkManagerProtocol {
    
    func fetch(url: URL,
               method: HTTPMethod,
               headers: [String : String] = [:],
               token: String? = nil,
               data: [String: Any]? = nil,
               completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetch(url: url,
              method: method,
              headers: headers,
              token: token,
              data: data,
              completionBlock: completionBlock)
    }
}
