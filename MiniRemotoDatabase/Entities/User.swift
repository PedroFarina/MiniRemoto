//
//  User.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 21/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import CloudKit
import CKDataConnector

public class User: EntityObject, Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.record.recordID == rhs.record.recordID
    }

    public static let recordType: String = "User"
    public var record: CKRecord

    public init(from record: CKRecord) {
        self.record = record
    }
}
