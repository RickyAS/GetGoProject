//
//  Service.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 17/02/23.
//

import Foundation
// MARK: - Main Service
class Service {
    /// Singleton
    static let shared = Service()
    /// All API method
    enum ServiceMethod: String {
        case get, post, put, delete
    }
    /// Handle API Error in user-friendly messsage
    enum ServiceError: String, Error {
        case badServer = "Server is down, try again later"
        case noData = "it seems like no data has been found"
        case decodingError = "Sorry, what you're looking for is not available"
    }
    
    /// Fetch data from API
    /// - Parameter method: API method
    /// - Parameter endpoint: path of the API
    /// - Parameter parameters: API parameters
    /// - Parameter responseType: model to decode
    /// - Parameter completion: get decodable model
    func request<T: Decodable>(_ method: ServiceMethod = .get, _ endpoint: NetworkEndpoint, parameters: [String: Any] = [:], responseType: T.Type, completion: @escaping (_ result: Result<T, ServiceError>) -> Void) {
        
        // construct url host and queries
        let host = "rickandmortyapi.com/api/"
        var components = URLComponents(string: "https://\(host)/\(endpoint.value)")!
        let queryItems = parameters.map({ key, val in
            URLQueryItem(name: key, value: "\(val)")
        })
        
        // set API method
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue.uppercased()
        
        // fetch data
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
                // decode data to model
                if let model = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(model))
                } else {
                    completion(.failure(.decodingError))
                }
            }
        }).resume()
    }
}

// MARK: - Network path
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
    
    /// Modify path with spesific parameters
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
