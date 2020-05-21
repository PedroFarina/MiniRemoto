//
//  DataController.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 21/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import CloudKit
import CKDataConnector

public class DataController {
    private init() {
    }
    private static var _shared: DataController = {
        let dataController = DataController()
        return dataController
    }()

    public class func shared() -> DataController {
        return _shared
    }

    internal func getEntityByID(_ id: CKRecord.ID) -> EntityObject? {
        return nil
    }
}
