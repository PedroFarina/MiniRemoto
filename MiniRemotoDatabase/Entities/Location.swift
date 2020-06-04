//
//  Location.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 22/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Location: Codable {
    public init(latitude: Double?, longitude: Double?, addressLine: String?, addressLine2: String?) {
        self.id = UUID().uuidString
        self.latitude = latitude
        self.longitude = longitude
        self.addressLine = addressLine
        self.addressLine2 = addressLine2
    }
    public var id: String?
    public var latitude: Double?
    public var longitude: Double?
    public var addressLine: String?
    public var addressLine2: String?
}
