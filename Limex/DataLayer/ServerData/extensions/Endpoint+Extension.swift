//
//  Endpoint+Extension.swift
//  Lime
//
//  Created by m.shirokova on 19.01.2023.
//

import UIKit

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "limehd.online"
        components.path = path
        return components.url
    }
}
