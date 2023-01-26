//
//  TVChannelsViewModel.swift
//  Limex
//
//  Created by m.shirokova on 17.01.2023.
//

// Review:
class TVChannelsViewModel {
    static let shared = TVChannelsViewModel() /// Нет смысла в сингл тоне, так как используется только один раз
    var allChannels: [TVChannel] = []
    func filteredChannels() -> [TVChannel] {
        if TVChannelFilterStateModel.isTVChannelFavouriteFilterEnabled() {
            let tvChannelsFavouritesString = UserDefaultsPersistance.shared.tvChannelsFavourites
            let tvChannelsFavouritesSet = tvChannelsFavouritesString?.fromStringToArraySeparatedBySymbol() ?? Set<Int>()
            var favouriteChannels: [TVChannel] = []
            for channel in allChannels {
                if tvChannelsFavouritesSet.contains(channel.id) {
                    favouriteChannels.append(channel)
                }
            }
            return favouriteChannels
        } else {
            return allChannels
        }
    }
    func tvChannels(completion: @escaping ([TVChannel]) -> Void ) {
        TVChannelsApiClient.shared.getTVChannels() { channels in
            self.allChannels = channels
            completion(channels)
        }
    }
}
