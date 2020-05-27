//
//  ContactsManager.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit
import Contacts

struct Contact {
    let id: String
    let givenName: String
    let familyName: String
    let email: String
    let number: String
}

class SelectableContact {
    var id: String = ""
    var givenName: String = ""
    var familyName: String = ""
    var email: String = ""
    var number: String = ""
    var isSelected: Bool = false

    init(id: String, givenName: String, familyName: String, email: String, number: String, isSelected: Bool) {
        self.id = id
        self.givenName = givenName
        self.familyName = familyName
        self.email = email
        self.number = number
        self.isSelected = isSelected
    }
}

class ContactsManager {

    private var contactStore = CNContactStore()
    var contacts = [Contact]()

    init() {
        requestAcess()
        contacts = fetchContacts()
    }

    private func requestAcess() {
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Authorization Succsesfull")
            }
        }
    }

    private func fetchContacts() -> [Contact] {

        var contacts = [Contact]()

        let key = [CNContactGivenNameKey,
                   CNContactFamilyNameKey,
                   CNContactEmailAddressesKey,
                   CNContactPhoneNumbersKey,
                   CNContactIdentifierKey] as [CNKeyDescriptor]

        let request = CNContactFetchRequest(keysToFetch: key)

        try! contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in

            let name = contact.givenName
            let familyName = contact.familyName
            let contactEmail = contact.emailAddresses.first?.value
            let contactNumber = contact.phoneNumbers.first?.value.stringValue
            let id = contact.identifier

            guard let email = contactEmail,
                let number = contactNumber else { return }

            let contact = Contact(id: id, givenName: name,
                                  familyName: familyName,
                                  email: email as String,
                                  number: number)

            contacts.append(contact)
        }

        return contacts
    }

    private func createSelectableContacts() -> [SelectableContact] {
        var selectableContacts = [SelectableContact]()

        contacts.forEach { (contact) in
            let id = contact.id
            let name = contact.givenName
            let familyName = contact.familyName
            let email = contact.email
            let number = contact.number
            let isSelected = false

            let selectableContact = SelectableContact(id: id, givenName: name, familyName: familyName, email: email, number: number, isSelected: isSelected)

            selectableContacts.append(selectableContact)
        }
        return selectableContacts
    }

    func getSelectableContacts() -> [SelectableContact] {
        return createSelectableContacts()
    }
}


