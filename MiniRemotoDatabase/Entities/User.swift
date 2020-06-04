//
//  User.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 22/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct User: Codable {
    internal init(id: String?, name: String?, events: [Event]? = nil) {
        self.id = id
        self.name = name
    }
    var id: String?
    var name: String?
    var events: [Event]?
}
