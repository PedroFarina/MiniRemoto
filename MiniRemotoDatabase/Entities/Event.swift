//
//  Event.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 22/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Event: Codable {
    internal init(ownerID: String?, name: String?, id: String?, color: String?, date: String?, startHour: String?, endHour: String?, shoppingList: [Item]?, location: Location?) {
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
    public var date: String?
    public var startHour: String?
    public var endHour: String?
    public var shoppingList: [Item]?
    public var location: Location?
}
