//
//  Invitee.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 04/06/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Invitee: Codable {
    public init(name: String, address: String) {
        self.name = name
        self.address = address
    }

    public var name: String?
    public var address: String?
}
