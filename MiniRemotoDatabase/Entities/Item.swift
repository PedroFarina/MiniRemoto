//
//  Item.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 22/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct Item: Codable {
    internal init(itemName: String?, whoBrings: String?) {
        self.itemName = itemName
        self.whoBrings = whoBrings
    }
    public var itemName: String?
    public var whoBrings: String?
}
