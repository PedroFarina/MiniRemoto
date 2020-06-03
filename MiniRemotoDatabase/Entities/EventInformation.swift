//
//  EventInformation.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 03/06/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public struct EventInformation: Codable {
    internal init(ownerID: String?, name: String?, id: String?, color: String?, date: String?, startHour: String?, endHour: String?) {
        self.ownerID = ownerID
        self.name = name
        self.id = id
        self.color = color
        self.date = date
        self.startHour = startHour
        self.endHour = endHour
    }
    
    public var ownerID: String?
    public var name: String?
    public var id: String?
    public var color: String?
    public var date: String?
    public var startHour: String?
    public var endHour: String?
}
