//
//  Response.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 02/06/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

internal struct Response: Codable {
    var result: Bool
}

public struct ResponseError: Error {
    public enum ErrorKind {
        case creatingUser
        case fetchingEvent
        case creatingEvent
        case internalError
    }

    public var kind: ErrorKind
    public var description: String {
        switch kind {
        case .creatingEvent:
            return "Couldn't create event".localized()
        case .creatingUser:
            return "Couldn't create user".localized()
        case .fetchingEvent:
            return "Couldn't fetch events".localized()
        case .internalError:
            return "Unexpected error".localized()
        }
    }
}
