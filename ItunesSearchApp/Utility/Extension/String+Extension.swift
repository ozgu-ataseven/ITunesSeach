//
//  String+Extension.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 3.05.2022.
//

import class Foundation.DateFormatter

extension String {
    func allowedString() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}

// MARK: Date
extension String {
    func formattedDate() -> String? {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let oldDate = olDateFormatter.date(from: self)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MMM dd yyyy"
        guard let oldDate = oldDate else { return nil }
        return convertDateFormatter.string(from: oldDate)
    }
}
