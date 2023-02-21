//
//  Service.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation

class Service {
    static let shared = Service()
    
    enum ServiceMethod: String {
        case get, post, put, delete
    }
    
    enum ServiceError: String, Error {
        case badServer = "Server is down, try again later"
        case noData = "it seems like no data has been found"
        case decodingError = "Sorry, what you're looking for is not available"
    }
    
    func request<T: Decodable>(_ method: ServiceMethod = .get, _ endpoint: NetworkEndpoint, parameters: [String: Any] = [:], responseType: T.Type, completion: @escaping (_ result: Result<T, ServiceError>) -> Void) {
        
        let host = "rickandmortyapi.com/api/"
        var components = URLComponents(string: "https://\(host)/\(endpoint.value)")!
        let queryItems = parameters.map({ key, val in
            URLQueryItem(name: key, value: "\(val)")
        })
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue.uppercased()
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) -> Void in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(.badServer))
                    return
                }
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                if let model = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(model))
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }).resume()
    }
}

enum NetworkEndpoint{
    case character(ids: [Int])
    case location(ids: [Int])
    case episode(ids: [Int])
    
    var value: String {
        switch self {
        case .character(let ids):
            return setPath("character", ids: ids)
        case .location(let ids):
            return setPath("location", ids: ids)
        case .episode(let ids):
            return setPath("episode", ids: ids)
        }
    }
    
    private func setPath(_ path: String, ids: [Int]) -> String {
        if ids.isEmpty {
            return path + "?"
        }
        var newPath = path + "/"
        ids.enumerated().forEach({ ind, val in
            newPath += ind != (ids.count-1) ? "\(val)," : "\(val)"
        })
        return newPath
    }
}
