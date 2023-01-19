//
//  StarImageView.swift
//  Limex
//
//  Created by m.shirokova on 19.01.2023.
//

import Foundation
import UIKit

final class StarImageView: UIImageView {
    var tvChannelId: Int?
    func addStarImage(tvChannelId: Int?) {
        guard let tvChannelId = tvChannelId else {
            return
        }
        image = nil
        let tvChannelsFavouritesString = UserDefaultsPersistance.shared.tvChannelsFavourites
        let tvChannelsFavouritesSet = tvChannelsFavouritesString?.fromStringToArraySeparatedBySymbol() ?? Set<Int>()
        if tvChannelsFavouritesSet.contains(tvChannelId) {
            image = UIImage(named: Images.selectedStar.rawValue)
        } else {
            image = UIImage(named: Images.star.rawValue)
        }
    }
}
