//
//  String+Extension.swift
//  Lime
//
//  Created by m.shirokova on 19.01.2023.
//

import Foundation

extension String {
    func fromStringToArraySeparatedBySymbol(_ char: String = ", ") -> Set<Int> {
        var setString = self
        setString.removeFirst()
        setString.removeLast()
        return Set(setString.components(separatedBy: char).map { Int($0) ?? 0 })
    }
}
