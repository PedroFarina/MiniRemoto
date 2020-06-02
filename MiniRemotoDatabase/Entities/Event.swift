//
//  Event.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 22/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Event: Codable {
    internal init(ownerID: String?, name: String?, id: String?, color: String?, date: Date?, shoppingListName: String?, shoppingList: [Item]?, location: Location?) {
        self.ownerID = ownerID
        self.name = name
        self.id = id
        self.color = color
        self.date = date
        self.shoppingList = shoppingList
        self.location = location
    }
    public var ownerID: String?
    public var name: String?
    public var id: String?
    public var color: String?
    public var date: Date?
    public var shoppingListName: String?
    public var shoppingList: [Item]?
    public var location: Location?
}
