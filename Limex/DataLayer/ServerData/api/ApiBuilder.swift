//
//  ApiBuilder.swift
//  Lime
//
//  Created by m.shirokova on 18.01.2023.
//

import UIKit

protocol ApiBuilderProtocol {
    func sendGetRequest(to url: URL, then handler: @escaping (Result<Data, Error>) -> Void)
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
final class ApiBuilder: ApiBuilderProtocol {
    func sendGetRequest(to url: URL, then handler: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            guard let data = data, error == nil else {
                handler(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            handler(.success(data))
        }
        task.resume()
    }
    func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.global(qos: .userInteractive).async {
                guard let data = data, error == nil else {
                    completion(.failure(error ?? URLError(.badServerResponse)))
                    return
                }
                completion(.success(data))
            }
        }
        task.resume()
    }
}
