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
// Review:
/// Неудачное название. В ООП есть паттерн строитель, для которого принято использовать это название. В контексте использования более удачное значение Network, NetworkService и т. п.
/// Неоправданное использование класса вместо структуры: не используется наследованные, нет передачи по ссылке и т. п.
/// В текущей реализации более удачное решение было бы использование статических методов;
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
            guard let data = data, error == nil else { /// повторяется излишне проверка error на nil
                handler(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            handler(.success(data))
        }
        task.resume()
    }
    /// отправка данных после получения в глобальную очередь лишено смысла: сетевой запрос в любом случае будет отправлен в последовательную очередь вне главной очереди:  com.apple.NSURLSession-delegate (serial).
    /// Некорректное название метода для downloadImage, т. к. метод не возваращает UIImage, а возращает сырые данные Data.
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
