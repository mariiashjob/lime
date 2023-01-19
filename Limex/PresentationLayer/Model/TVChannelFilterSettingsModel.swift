//
//  TVChannelFilterSettingsModel.swift
//  Lime
//
//  Created by m.shirokova on 18.01.2023.
//

final class TVChannelFilterSettingsModel {
    var type: TVChannelFilterTypeModel
    var isEnabled: Bool
    init(type: TVChannelFilterTypeModel, isEnabled: Bool = false) {
        self.type = type
        self.isEnabled = isEnabled
    }
}
