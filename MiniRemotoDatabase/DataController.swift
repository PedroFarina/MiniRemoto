//
//  DataController.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 21/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import CloudKit
import EndpointsRequests

internal struct Response: Codable {
    var success: Bool
}

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

    private static let hostaddress = "localhost:8000"
    public private(set) var user: User?
    public private(set) var events: [Event] = []

    internal func fetchEvent(with id: String) {
        EndpointsRequests.Requests.getRequest(url: "\(DataController.hostaddress)/getEvents/\(id)", decodableType: Event.self) { (answer) in
            //TODO: Feed events array
            switch answer {
            case .result(let result):
                print(result)
            case .error(let err):
                print(err.localizedDescription)
            }
        }
    }

    public func createUser(with name: String) {
        let id = UUID().uuidString
        let user = User(id: id, name: name)
        EndpointsRequests.Requests.postRequest(url: "\(DataController.hostaddress)/createUser", params: user, decodableType: Response.self) { (answer) in
            //TODO: Save user(id) in App Group User Defaults
            switch answer {
            case .result(let result):
                print(result)
            case .error(let err):
                print(err.localizedDescription)
            }
        }
    }

    public func createEvent(_ event: Event) {
        EndpointsRequests.Requests.postRequest(url: "\(DataController.hostaddress)/createEvent", params: event, decodableType: Response.self) { (answer) in
            //TODO: Rollback if not success
            switch answer {
            case .result(let result):
                print(result)
            case .error(let err):
                print(err.localizedDescription)
            }
        }
    }
}
