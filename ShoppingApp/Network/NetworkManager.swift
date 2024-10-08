//
//  NetworkManager.swift
//  ShoppingApp
//
//  Created by Chuan Pham on 14.02.2024.
//

import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Codable>(_ type: T.Type, url: String, method: HTTPMethod, completion: @escaping((Result<T,Error>)->())){
        AF.request(url, method: method)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
//            .response(completionHandler: { results in
//                if let data = results.data, let utf8Text = String(data: data, encoding: .utf8) {
//                    print("\n Data: \(utf8Text)")
//                }
//            })
    }
}
