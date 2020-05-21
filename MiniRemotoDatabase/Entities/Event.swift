//
//  Event.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 21/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import CloudKit
import CKDataConnector

public class Event: EntityObject, Equatable {
    public static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.record.recordID == rhs.record.recordID
    }

    public static let recordType: String = "Event"
    public var record: CKRecord
    

    public init(from record: CKRecord) {
        self.record = record
    }
}
