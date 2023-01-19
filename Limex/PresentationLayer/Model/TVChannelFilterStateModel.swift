//
//  TVChannelFilterStateModel.swift
//  Lime
//
//  Created by m.shirokova on 18.01.2023.
//

import Foundation

protocol TVChannelFilterStateModelDelegate {
    var tvChannelsViewDelegate: TVChannelsViewDelegate? { get set }
    func switchOnTVChannelFilterState(_ type: TVChannelFilterTypeModel?)
    func isTVChannelFilterTypeSelected(_ type: TVChannelFilterTypeModel?) -> Bool
}

struct TVChannelFilterStateModel: TVChannelFilterStateModelDelegate {
    var tvChannelsViewDelegate: TVChannelsViewDelegate?
    static var shared = TVChannelFilterStateModel()
    private var tvChannelFilters = [TVChannelFilterSettingsModel(type: TVChannelFilterTypeModel.all, isEnabled: true),
                                    TVChannelFilterSettingsModel(type: TVChannelFilterTypeModel.favourites)]
    static func isTVChannelFavouriteFilterEnabled() -> Bool {
        TVChannelFilterStateModel.shared.isTVChannelFilterTypeSelected(TVChannelFilterTypeModel.favourites)
    }
    func switchOnTVChannelFilterState(_ type: TVChannelFilterTypeModel?) {
        guard let type = type else {
            return
        }
        for tvChannelFilter in tvChannelFilters {
            if tvChannelFilter.type == type {
                tvChannelFilter.isEnabled = true
            } else {
                tvChannelFilter.isEnabled = false
            }
        }
        tvChannelsViewDelegate?.updateView()
    }
    func isTVChannelFilterTypeSelected(_ type: TVChannelFilterTypeModel?) -> Bool {
        guard let type = type else {
            return false
        }
        return tvChannelFilters.filter { $0.type == type }.first?.isEnabled ?? false
    }
}
