//
//  Event.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 03/06/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Event: Codable {
    internal init(info: EventInformation?, shoppingList: [Item]?, location: Location?) {
        self.event = info
        self.shoppingList = shoppingList
        self.location = location
    }
    public var event: EventInformation?
    public var shoppingList: [Item]?
    public var location: Location?
}
