//
//  ReferenceField.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 21/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import CloudKit
import CKDataConnector

public class ReferenceField<T: EntityObject> {
    private let record: CKRecord
    private let key: String
    private let action: CKRecord_Reference_Action
    public private(set) var referenceValue: CKRecord.Reference?
    private lazy var _value: T? = {
        guard let referenceValue = referenceValue,
            let value = DataController.shared().getEntityByID(referenceValue.recordID) as? T else {
            return nil
        }
        return value
    }()

    public var value: T? {
        get {
            return _value
        }
        set {
            if let newValue = newValue {
                referenceValue = CKRecord.Reference(recordID: newValue.record.recordID, action: action)
                record.setValue(referenceValue, forKey: key)
            } else {
                referenceValue = nil
                record.setValue(nil, forKey: key)
            }
            _value = newValue
        }
    }

    public init(record: CKRecord, key: String, action: CKRecord_Reference_Action) {
        self.record = record
        self.key = key
        self.action = action
        self.referenceValue = record.value(forKey: key) as? CKRecord.Reference
    }
}

extension ReferenceField where T: Equatable {
    static func == (lhs: T, rhs: ReferenceField) -> Bool {
        return lhs == rhs.value
    }
    static func != (lhs: T, rhs: ReferenceField) -> Bool {
        return lhs != rhs.value
    }

    static func == (lhs: ReferenceField, rhs: T) -> Bool {
        return lhs.value == rhs
    }
    static func != (lhs: ReferenceField, rhs: T) -> Bool {
        return lhs.value != rhs
    }
}
