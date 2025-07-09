//
//  ArticleListNetworkService.swift
//  NewsApp
//
//  Created by Хасан Магомедов on 31.12.2023.
//

import Foundation

final class ArticleListNetworkService {
    
    func fetchData(
        q: String?,
        page: Int,
        completion: @escaping (ArticlesResult) -> Void
    ) {
        let urlString = stringUrl(q: q, page: page)
        
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            guard let result = try? JSONDecoder().decode(ArticlesResult.self, from: data) else {
                print("Can not decode data")
                return 
            }
            
            completion(result)
        }.resume()
    }
    
    private func stringUrl(q: String?, page: Int) -> String {
        var baseString = "https://newsapi.org/v2/everything?sortBy=publishedAt&apiKey=521371c3d78948ce8464c189dbb65f8b&language=ru"
        
        if let q = q {
            baseString += "&q=\(q)"
        }
        
        baseString += "&page=\(page)"
        
        return baseString
    }
}
