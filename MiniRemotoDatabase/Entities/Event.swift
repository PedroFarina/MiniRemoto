//
//  Event.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 03/06/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Event: Codable {
    internal init(info: EventInformation?, shoppingList: [Item]?, location: Location?, invitees: [Invitee]?) {
        self.event = info
        self.shoppingList = shoppingList
        self.location = location
        self.invitees = invitees
    }
    mutating func changeInfo(to newInformation: EventInformation?) {
        event = newInformation
    }
    mutating func changeShoppingList(to newShoppingList: [Item]?) {
        shoppingList = newShoppingList
    }
    mutating func changeLocation(to newLocation: Location?) {
        location = newLocation
    }
    public var event: EventInformation?
    public var shoppingList: [Item]?
    public var location: Location?
    public var invitees: [Invitee]?
}
