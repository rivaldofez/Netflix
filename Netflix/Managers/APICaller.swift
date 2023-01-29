//
//  APICaller.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 29/01/23.
//

import Foundation

struct Constants {
    static let API_KEY = "d63d4fcb8d25c828fe89669f635ff545"
    static let baseURL = "https://api.themoviedb.org"
}


class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (String) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)3/trending/all/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            
        }
    }
}
