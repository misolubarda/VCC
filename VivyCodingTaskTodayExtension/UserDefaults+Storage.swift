//
//  UserDefaults+Storage.swift
//  VivyCodingTaskTodayExtension
//
//  Created by Lubarda, Miso on 02.02.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

extension UserDefaults {
    private static let currentCountryKey = "keyTodayCountryName"

    static var currentCountry: CurrentCountry? {
        return standard.load(CurrentCountry.self, for: currentCountryKey)
    }

    static func save(_ currentCountry: CurrentCountry) {
        standard.save(object: currentCountry, for: currentCountryKey)
    }

    func load<T>(_ type: T.Type, for key: String) -> T? where T: Decodable {
        guard let data = object(forKey: key) as? Data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func save<T>(object: T, for key: String) where T: Encodable {
        guard let data = try? JSONEncoder().encode(object) else { return }
        set(data, forKey: key)
    }
}
