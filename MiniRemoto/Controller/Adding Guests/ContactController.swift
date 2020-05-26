//
//  ContactController.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import Contacts
import UIKit

struct Contact {
    let givenName: String
    let familyName: String
    let email: String
    let number: String
    let id: String
}

class ContactsController: NSObject {

    private var contactStore = CNContactStore()

    func requestAccess()  {
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Authorization Succsesfull")
            }
        }
//        fetchContacts()
    }

    func getContacts() -> [Contact] {
        return fetchContacts()
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

            let contact = Contact(givenName: name,
                                  familyName: familyName,
                                  email: email as String,
                                  number: number, id: id)

            contacts.append(contact)
        }

        return contacts
    }
}
