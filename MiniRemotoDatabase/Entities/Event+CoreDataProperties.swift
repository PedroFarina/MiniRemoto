//
//  Event+CoreDataProperties.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 09/07/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var event: EventInformation?
    @NSManaged public var shoppingList: NSOrderedSet?
    @NSManaged public var location: Location?
    @NSManaged public var invitees: NSOrderedSet?

}

// MARK: Generated accessors for shoppingList
extension Event {

    @objc(insertObject:inShoppingListAtIndex:)
    @NSManaged public func insertIntoShoppingList(_ value: Item, at idx: Int)

    @objc(removeObjectFromShoppingListAtIndex:)
    @NSManaged public func removeFromShoppingList(at idx: Int)

    @objc(insertShoppingList:atIndexes:)
    @NSManaged public func insertIntoShoppingList(_ values: [Item], at indexes: NSIndexSet)

    @objc(removeShoppingListAtIndexes:)
    @NSManaged public func removeFromShoppingList(at indexes: NSIndexSet)

    @objc(replaceObjectInShoppingListAtIndex:withObject:)
    @NSManaged public func replaceShoppingList(at idx: Int, with value: Item)

    @objc(replaceShoppingListAtIndexes:withShoppingList:)
    @NSManaged public func replaceShoppingList(at indexes: NSIndexSet, with values: [Item])

    @objc(addShoppingListObject:)
    @NSManaged public func addToShoppingList(_ value: Item)

    @objc(removeShoppingListObject:)
    @NSManaged public func removeFromShoppingList(_ value: Item)

    @objc(addShoppingList:)
    @NSManaged public func addToShoppingList(_ values: NSOrderedSet)

    @objc(removeShoppingList:)
    @NSManaged public func removeFromShoppingList(_ values: NSOrderedSet)

}

// MARK: Generated accessors for invitees
extension Event {

    @objc(insertObject:inInviteesAtIndex:)
    @NSManaged public func insertIntoInvitees(_ value: Invitee, at idx: Int)

    @objc(removeObjectFromInviteesAtIndex:)
    @NSManaged public func removeFromInvitees(at idx: Int)

    @objc(insertInvitees:atIndexes:)
    @NSManaged public func insertIntoInvitees(_ values: [Invitee], at indexes: NSIndexSet)

    @objc(removeInviteesAtIndexes:)
    @NSManaged public func removeFromInvitees(at indexes: NSIndexSet)

    @objc(replaceObjectInInviteesAtIndex:withObject:)
    @NSManaged public func replaceInvitees(at idx: Int, with value: Invitee)

    @objc(replaceInviteesAtIndexes:withInvitees:)
    @NSManaged public func replaceInvitees(at indexes: NSIndexSet, with values: [Invitee])

    @objc(addInviteesObject:)
    @NSManaged public func addToInvitees(_ value: Invitee)

    @objc(removeInviteesObject:)
    @NSManaged public func removeFromInvitees(_ value: Invitee)

    @objc(addInvitees:)
    @NSManaged public func addToInvitees(_ values: NSOrderedSet)

    @objc(removeInvitees:)
    @NSManaged public func removeFromInvitees(_ values: NSOrderedSet)

}
