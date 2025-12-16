//
//  FunFactsAPIManager.swift
//  ChuckNorrisCategories
//
//  Created by elene malakmadze on 16.12.25.
//

import Foundation

enum FunFactCategory: Int {
    case animal = 0
    case dev
    case travel
    
    var endPoint: String {
        switch self {
        case .animal: "animal"
        case .dev: "dev"
        case .travel: "travel"
        }
    }
}

protocol FunFactsAPIManagerProtocol {
    func fetchFunFacts(with type: FunFactCategory, completion: @escaping (Result<FunFact, Error>) -> ())
}

class FunFactsAPIManager: FunFactsAPIManagerProtocol {
    func fetchFunFacts(with type: FunFactCategory, completion: @escaping (Result<FunFact, Error>) -> ()) {
        let urlString = "https://api.chucknorris.io/jokes/random?category=\(type.endPoint)"
        guard let url = URL(string: urlString) else { return }
        
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let error {
            completion(.failure(error))
            print(error)
        }
        
        guard let data else { return }
        
        do {
            let decodedData = try JSONDecoder().decode(FunFact.self, from: data)
            DispatchQueue.main.async {
                completion(.success(decodedData))
            }
        } catch {
            completion(.failure(error))
        }
    }.resume()
}
    
    
}
