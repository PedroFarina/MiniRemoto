//
//  Invitee+CoreDataProperties.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 09/07/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


extension Invitee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invitee> {
        return NSFetchRequest<Invitee>(entityName: "Invitee")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var event: Event?

}
