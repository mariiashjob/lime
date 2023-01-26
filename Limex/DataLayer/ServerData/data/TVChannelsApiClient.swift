//
//  TVChannelsApiClient.swift
//  Limex
//
//  Created by m.shirokova on 18.01.2023.
//

import Foundation
import UIKit

final class TVChannelsApiClient {
    static let shared = TVChannelsApiClient(apiBuilder: ApiBuilder()) /// неоправданное решение синглтона, используется только один раз во всем приложении
    private var apiBuilder: ApiBuilderProtocol? /// Нет смысла использовать опционал
    init(apiBuilder: ApiBuilderProtocol?) {
        self.apiBuilder = apiBuilder
    }
    func getTVChannels(completion: @escaping ([TVChannel]) -> Void) {
        guard let url = Endpoint(path: "/playlist/channels.json").url else {
            return
        }
        apiBuilder?.sendGetRequest(to: url) { result in
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(TVChannelsResponse.self, from: result.get())
                completion(response.channels)
            } catch {
                // Review:
                /// Никак не обрабатывается ошибка! 
                print(error.localizedDescription)
            }
        }
    }
}
