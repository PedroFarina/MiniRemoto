//
//  DataController.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 21/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import EndpointsRequests

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

    private static let hostaddress = "https://evedb.herokuapp.com"
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
    
    public private(set) var user: User?
    public private(set) var events: [Event] = []

    internal func fetchEvents() {
        EndpointsRequests.Requests.getRequest(url: "\(DataController.hostaddress)/getEvents/\(user?.id ?? "")", decodableType: [Event].self) { (answer) in
            switch answer {
            case .result(let result as [Event]):
                self.events = result
                self.notifyObservers()
            case .error(let err):
                self.delegate?.didOccur(err)
            default:
                self.delegate?.didOccur(ResponseError(kind: .internalError))
            }
        }
    }

    public func createUser() {
        let id = UUID().uuidString
        let user = User(id: id, name: nil)
        EndpointsRequests.Requests.postRequest(url: "\(DataController.hostaddress)/createUser", params: user, decodableType: Response.self) { (answer) in
            switch answer {
            case .result(let result as Response):
                if result.result {
                    //TODO: Save user(id) in App Group User Defaults
                    self.user = user
                } else {
                    self.delegate?.didOccur(ResponseError(kind: .creatingUser))
                }
            case .error(let err):
                self.delegate?.didOccur(err)
            default:
                self.delegate?.didOccur(ResponseError(kind: .internalError))
            }
        }

    }

    public func createEvent(name: String, color: AppColor, startDate: Date?, endDate: Date?, items: [Item]?, location: Location?) {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        var date: String? = nil
        var startHour: String? = nil
        var endHour: String? = nil
        if let startDate = startDate, let endDate = endDate {
            date = df.string(from: startDate)
            df.dateFormat = "hh:mm"
            startHour = df.string(from: startDate)
            endHour = df.string(from: endDate)
        }

        let event = Event(ownerID: user?.id, name: name, id: UUID().uuidString, color: color.rawValue, date: date, startHour: startHour, endHour: endHour, shoppingList: items, location: location)
        EndpointsRequests.Requests.postRequest(url: "\(DataController.hostaddress)/createEvent", params: event, decodableType: Response.self) { (answer) in
            switch answer {
            case .result(let result as Response):
                if result.result {
                    self.events.append(event)
                    self.notifyObservers()
                } else {
                    self.delegate?.didOccur(ResponseError(kind: .creatingEvent))
                }
            case .error(let err):
                self.delegate?.didOccur(err)
            default:
                self.delegate?.didOccur(ResponseError(kind: .internalError))
            }
        }
    }
}
