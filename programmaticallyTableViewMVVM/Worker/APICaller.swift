//
//  APICaller.swift
//  programmaticallyTableViewMVVM
//
//  Created by Hamed Amiry on 22.07.2021.
//

import Foundation

final class ParsingJson {
    static let shared = ParsingJson()
    struct Constants {
        static let topHeadLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apikey=7ecc4ef51b0940969327f7a145a19612")
    }
    
    private init() {}
    
    public func getNews(completion: @escaping (Result<[Article],Error>)-> Void) {
        guard let url = Constants.topHeadLinesURL else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    

}
