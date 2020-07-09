//
//  NSCustomPersistantContainer.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 08/07/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

import CoreData

class NSCustomPersistentContainer: NSPersistentContainer {

    override open class func defaultDirectoryURL() -> URL {
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Eeve")
        storeURL = storeURL?.appendingPathComponent("Eeve")
        if let url = storeURL {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
        }
        return storeURL!
    }

}
