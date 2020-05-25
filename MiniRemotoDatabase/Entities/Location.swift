//
//  Location.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 22/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Location: Codable {
    public var id: String?
    public var latitude: Double?
    public var longitude: Double?
    public var addressLine: String?
    public var addressLine2: String?
}
