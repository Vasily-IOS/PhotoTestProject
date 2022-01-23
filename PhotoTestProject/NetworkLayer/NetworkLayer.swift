//
//  NetworkLayer.swift
//  PhotoTestProject
//
//  Created by Василий on 21.01.2022.
//

import Foundation

final class NetworkLayer {

// MARK: - random photo

    func fetchData(completion: @escaping (Result<[Results], Error>) -> Void){

        let randomURL =
        """
        https://api.unsplash.com/search/photos?&per_page=15&query=different&client_id=7pMH0hVDWRVYOFrfLiFJr9amnGeZMbCpZ35DPtN32MY
        """

        guard let url = URL(string: randomURL) else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared

        session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(SearchModel.self, from: data)
                completion(.success(json.results))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

// MARK: - search photo

    func fetchSearchData(query: String, completion: @escaping (Result<[Results], Error>) -> Void){

        let searchURL =
        """
        https://api.unsplash.com/search/photos?&per_page=15&query=\(query)&client_id=7pMH0hVDWRVYOFrfLiFJr9amnGeZMbCpZ35DPtN32MY
        """
        guard let url = URL(string: searchURL) else { return }
        let request = URLRequest(url: url)
        let session = URLSession.shared

        session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(SearchModel.self, from: data)
                completion(.success(json.results))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

}
