//
//  NetworkClient.swift
//  NCSS
//
//  Created by Edward Poon on 4/17/21.
//

import Foundation

public enum NetworkResult<Value> {
  case success(Value)
  case failure(Error?)
}

protocol NetworkClientProtocol {
    func loadData(from url: URL, completionHandler: ((NetworkResult<Data>) -> Void)?)
    func sendData<I: Codable>(to url: URL, body: I, completionHandler: ((NetworkResult<Data>) -> Void)?)
}

class NetworkClient: NetworkClientProtocol {
    
    var session: URLSession
    
    init() {        
        self.session = URLSession.shared
    }
    
    func loadData(from url: URL, completionHandler:((NetworkResult<Data>) -> Void)?) {
        get(from: url) { (data, error) in
            let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
            completionHandler?(result)
        }
    }
    
    func sendData<I>(to url: URL, body: I, completionHandler: ((NetworkResult<Data>) -> Void)?) where I : Decodable, I : Encodable {
        var request = URLRequest(url: url)
        do {
            let httpBody = try JSONEncoder().encode(body)
            request.httpBody = httpBody
            request.httpMethod = "POST"
            post(with: request) { (data, error) in
                let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                completionHandler?(result)
            }
        }
        catch {
            completionHandler?(.failure(error))
        }
    }
    
    private func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = session.dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
    
    private func post(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = session.dataTask(with: urlRequest) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}
