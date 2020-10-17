//
//  AddEventViewController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import MiniRemotoDatabase
import EventKit

public class AddEventViewController: UIViewController, ModuleStateDelegate, ModuleSelectorDelegate, UITextFieldDelegate {

    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtEventName: SlashedTextField!
    @IBOutlet weak var moduleCollectionView: UICollectionView!
    let collectionDelegate = ModuleCollectionViewDelegate()
    let collectionDataSource = ModuleCollectionViewDataSource()
    @IBOutlet weak var moduleTableView: UITableView!
    let tableDelegate = ModuleTableViewDelegate()
    let tableDataSource = ModuleTableViewDataSource()

    var eventStore = EKEventStore()

    public override func viewDidLoad() {
        txtEventName.delegate = self

        moduleCollectionView.delegate = collectionDelegate
        moduleCollectionView.dataSource = collectionDataSource
        moduleTableView.delegate = tableDelegate
        moduleTableView.dataSource = tableDataSource
        moduleTableView.tableFooterView = UIView()
        collectionDelegate.delegate = self
        tableDelegate.delegate = self

        txtEventName.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    }

    func requestAuthorization() {
        eventStore.requestAccess(to: .event) { (sucess, err) in
            if !sucess {
                print(err?.localizedDescription)
            } else {
                print("usuário concedeu acesso")
            }
        }
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    public func didAdd(_ module: Module) {
        tableDataSource.didAdd(module)
        reloadData()
    }

    public func didRemove(_ module: Module) {
        tableDataSource.didRemove(module)
        reloadData()
    }

    public func didSelect(_ module: Module) {
        if let controller = UIStoryboard(name: type(of: module).storyboardName, bundle: nil).instantiateViewController(withIdentifier: "main") as? ModuleController {
            controller.module = module
            controller.reloadData = reloadData
            self.present(controller, animated: true)
        }
    }

    private func reloadData() {
        moduleTableView.reloadData()
        checkDone()
    }

    @objc func textChanged(_ sender: UITextField) {
        checkDone()
    }

    @objc func checkDone() {
        var check: Bool = !(txtEventName.text?.isEmpty ?? true)
        tableDataSource.modules.forEach { (mod) in
            check = check && mod.isFilled()
        }
        if tableDataSource.modules.isEmpty {
            btnDone.isEnabled = false
        } else {
            btnDone.isEnabled = check
        }
    }

    var failAlert: UIAlertController {
        let alert: UIAlertController
        if moduleTableView.visibleCells.count == 0 {
            alert = UIAlertController(title: "Oops!".localized(), message: "Para criar seu evento, é necessário adicionar módulos.".localized(), preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: "Oops!".localized(), message: "Toque nos módulos adicionados para preenchê-los".localized(), preferredStyle: .alert)
        }
        alert.view.tintColor = UIColor(named: "Action Color")

        let action = UIAlertAction(title: "OK".localized(), style: .default)
        alert.addAction(action)
        return alert
    }

    @IBAction func fallbackTap(_ sender: Any) {
        self.present(failAlert, animated: true)
    }
    @IBAction func doneTap(_ sender: Any) {
        var startDate: String? = nil, startHour: String? = nil, endHour: String? = nil, list: [Item]? = nil, location: Location? = nil, invitees: [Invitee]? = nil

        var calendarLocation: String = ""
        var calendarStartDate: Date = Date()
        var calendarEmails: [String] = []

        for module in tableDataSource.modules {
            if let calendarData = module as? CalendarData {
                startDate = calendarData.sDate
                startHour = calendarData.sHour
                endHour = calendarData.eHour
                calendarStartDate = calendarData.startDate ?? Date()

            } else if let locationData = module as? LocationData,
                let coordinates = locationData.location?.placemark.coordinate,
                let location = DataController.shared().makeLocation() {
                location.latitude = coordinates.latitude
                location.longitude = coordinates.longitude
                location.addressLine = locationData.title
                location.addressLine2 = locationData.addressLine2
                calendarLocation = "\(String(describing: locationData.title)) \(String(describing: locationData.addressLine2))"

            } else if let listData = module as? ListData,
                let itemList = listData.itemList {
                var items: [Item] = []
                for itemName in itemList {
                    if let itemObject = DataController.shared().makeItem() {
                        itemObject.name = itemName
                        items.append(itemObject)
                    }
                }
                list = items
            } else if let inviteData = module as? InviteData,
                let guests = inviteData.guests {
                invitees = []
                for guest in guests {
                    if let invitee = DataController.shared().makeInvitee() {
                        invitee.name = guest.givenName
                        invitee.email = guest.email
                        invitees?.append(invitee)
                        calendarEmails.append(guest.email)
                    }
                }
            }
        }

        DataController.shared().createEvent(name: txtEventName.text ?? "Evento".localized(), color: MiniRemotoDatabase.AppColor.getRandom(), startDate: startDate, startHour: startHour, endHour: endHour, items: list, location: location, invitees: invitees)


        requestAuthorization()
        createEventInCalendar(eventTitle: txtEventName.text ?? "Evento".localized(), location: calendarLocation, startDate: calendarStartDate, guests: calendarEmails)

        self.dismiss(animated: true)
    }


    func createEventInCalendar(eventTitle: String, location: String, startDate: Date, guests: [String]) {

        let event = EKEvent(eventStore: eventStore)
        event.title = eventTitle
        event.location = location
        event.startDate = startDate
        event.endDate = startDate
        event.calendar = eventStore.defaultCalendarForNewEvents

        var attendees = [EKParticipant]()
        for email in guests {
            if let attendee = createParticipant(email: email) {
                attendees.append(attendee)
            }
        }

        event.setValue(attendees, forKey: "attendees")

        do {
            try eventStore.save(event, span: .thisEvent)
        } catch let err {
            print(err.localizedDescription)
        }
    }

    private func createParticipant(email: String) -> EKParticipant? {
        let clazz: AnyClass? = NSClassFromString("EKAttendee")
        if let type = clazz as? NSObject.Type {
            let attendee = type.init()
            attendee.setValue(email, forKey: "emailAddress")
            return attendee as? EKParticipant
        }
        return nil
    }

    @IBAction func cancelTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
