//
//  URLSessionProtocol.swift
//  Networking
//
//  Created by Glauco Moraes on 24/11/20.
//

import Foundation

public protocol URLSessionProtocol {
    associatedtype dataTaskProtocolType: URLSessionDataTaskProtocol
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> dataTaskProtocolType
}
