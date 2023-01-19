//
//  TVChannel.swift
//  Lime
//
//  Created by m.shirokova on 18.01.2023.
//

import Foundation

struct TVChannel: Codable {
    let id: Int
    let name: String
    let image: String
    let current: TVChannelCurrent
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "name_ru"
        case image
        case current
    }
}
