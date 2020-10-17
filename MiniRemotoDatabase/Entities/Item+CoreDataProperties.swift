//
//  Item+CoreDataProperties.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 09/07/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var event: Event?

}
