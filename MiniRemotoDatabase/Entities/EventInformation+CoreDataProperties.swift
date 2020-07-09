//
//  EventInformation+CoreDataProperties.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 09/07/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


extension EventInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventInformation> {
        return NSFetchRequest<EventInformation>(entityName: "EventInformation")
    }

    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var date: String?
    @NSManaged public var startHour: String?
    @NSManaged public var endHour: String?
    @NSManaged public var event: Event?

}
