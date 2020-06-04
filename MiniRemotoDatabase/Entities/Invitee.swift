//
//  Invitee.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 04/06/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Invitee: Codable {
    public init(name: String, email: String) {
        self.name = name
        self.email = email
    }

    public var name: String?
    public var email: String?
}
