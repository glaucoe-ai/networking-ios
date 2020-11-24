//
//  NetworkManager.swift
//  Networking
//
//  Created by Glauco Moraes on 24/11/20.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case bodyInGet
    case invalidURL
    case noInternet
    case invalidResponse(Data?, URLResponse?)
    case accessForbidden
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public class NetworkManager<T: URLSessionProtocol> {
    public let session: T
    
    public required init(session: T) {
        self.session = session
    }
    
    var task: T.dataTaskProtocolType?

    
    public convenience init() {
        self.init(session: URLSession.shared as! T)
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, data: [String: Any]? = nil, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        if method == .get {
            guard data == nil else {
                completionBlock(.failure(NetworkError.bodyInGet))
                return
            }
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let bearerToken = token {
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let data = data {
            var serializedData: Data?
            
            do {
                serializedData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            } catch {
                completionBlock(.failure( ErrorModel(errorDescription: "Could not serialize data") ))
            }
            
            request.httpBody = serializedData
        }
        
        task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            guard
                let _ = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    if let data = data {
                        completionBlock(.success(data))
                    } else {
                        completionBlock(.failure(NetworkError.invalidResponse(data, response)))
                    }
                    return
            }
            if let data = data {
                completionBlock(.success(data))
            }
        }
        task?.resume()
    }
}

