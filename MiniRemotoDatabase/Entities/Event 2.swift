//
//  Event.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 22/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Event: Codable {
    public var ownerID: String?
    public var name: String?
    public var id: String?
    public var color: String?
    public var date: Date?
    public var shoppingListName: String?
    public var shoppingList: [Item]?
    public var location: Location
}
