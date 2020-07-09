//
//  DataController.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 21/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import CoreData
import Foundation
import UIKit


public class DataController {
    private init() {
        events = try! context.fetch(Event.fetchRequest())
    }
    private static var _shared: DataController = {
        let dataController = DataController()
        return dataController
    }()
    
    public class func shared() -> DataController {
        return _shared
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSCustomPersistentContainer(name: "EventModel")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private lazy var context:NSManagedObjectContext = persistentContainer.viewContext

    public weak var delegate: DBErrorDelegate?
    private var observers: [DBObserver] = []
    public func registerAsObserver(_ observer: DBObserver) {
        observers.append(observer)
    }
    public func removeAsObserver(_ observer: DBObserver) {
        if let index = observers.firstIndex(where: {$0 === observer}) {
            observers.remove(at: index)
        }
    }
    private func notifyObservers() {
        for observer in observers {
            observer.didUpdateData()
        }
    }

    public private(set) var events: [Event] = []

    public func makeItem() -> Item? {
        return NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item
    }

    public func makeInvitee() -> Invitee? {
        return NSEntityDescription.insertNewObject(forEntityName: "Invitee", into: context) as? Invitee
    }

    public func makeLocation() -> Location? {
        NSEntityDescription.insertNewObject(forEntityName: "Location", into: context) as? Location
    }

    public func createEvent(name: String, color: AppColor, startDate: String?, startHour: String?, endHour: String?, items: [Item]?, location: Location?, invitees: [Invitee]?) {
        guard let info = NSEntityDescription.insertNewObject(forEntityName: "EventInformation", into: context) as? EventInformation,
            let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as? Event else {
            return
        }
        info.name = name
        info.color = color.rawValue
        info.date = startDate
        info.startHour = startHour
        info.endHour = endHour
        event.event = info

        if let location = location {
            event.location = location
        }
        if let invitees = invitees {
            for invitee in invitees {
                event.addToInvitees(invitee)
            }
        }
        if let items = items {
            for item in items {
                event.addToShoppingList(item)
            }
        }

        self.events.append(event)
        try! saveContext()
        self.notifyObservers()
    }

    private func saveContext() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Could not save context.")
            }
        }
    }
}
