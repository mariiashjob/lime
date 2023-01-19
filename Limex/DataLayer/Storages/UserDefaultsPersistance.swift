//
//  UserDefaultsPersistance.swift
//  Limex
//
//  Created by m.shirokova on 19.01.2023.
//
import Foundation

class UserDefaultsPersistance {
    
    static let shared = UserDefaultsPersistance()
    private let defaults = UserDefaults.standard
    private let kTVChannelsFavouritesKey = "UserDefaultsPersistance.kTVChannelsFavouritesKey"
    
    var tvChannelsFavourites: String? {
        set { defaults.set(newValue, forKey: kTVChannelsFavouritesKey) }
        get { return defaults.string(forKey: kTVChannelsFavouritesKey) }
    }
}
