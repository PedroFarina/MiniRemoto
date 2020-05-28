//
//  ContactsTableViewDataSource.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

struct Section {
    let title: String
    var contacts: [SelectableContact]
}

class ContactsTableViewDataSource: NSObject, UITableViewDataSource {

    let CONTACTSCELL = "ContactsTableViewCell"
    var contacts: [SelectableContact]
    var searchRes: [SelectableContact] = []
    var sections = [Section]()
    var isSearching: Bool = false

    let alphabet = ["A", "B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

    init(contacts: [SelectableContact]) {
        self.contacts = contacts
        super.init()
        setupSections()
    }

    func getSections() -> [Section] {
        return sections
    }

    func setupSections() {
        for character in alphabet {
            let title = character
            let contacts = groupBy(letter: character)
            let section = Section(title: title, contacts: contacts)
            sections.append(section)
        }
    }

    func groupBy(letter: String) -> [SelectableContact] {
        var alphabeticalGroup: [SelectableContact] = []

        contacts.forEach { (contact) in
            let firstLetterInFirstName = String(contact.givenName.first ?? Character("Z"))
            if firstLetterInFirstName == letter {
                alphabeticalGroup.append(contact)
            }
        }
        return alphabeticalGroup
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        switch isSearching {
        case true:
            return 1
        case false:
            return sections.count
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isSearching {
        case true:
            return searchRes.count
        case false:
            let contacts = sections[section].contacts
            return contacts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CONTACTSCELL) as? ContactsTableViewCell

        switch isSearching {

        case true:
            cell?.contact = searchRes[indexPath.row]

        case false:
            let contacts = sections[indexPath.section].contacts
            cell?.contact = contacts[indexPath.row]
        }

        return cell ?? ContactsTableViewCell()
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return alphabet
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    public func unselect(_ contact: SelectableContact) {
        contacts.forEach { (arContact) in
            if arContact.id == contact.id {
                contact.isSelected = false
            }
        }
    }
}

extension ContactsTableViewDataSource: GetSearchResponse {

    func changeSearchStatus(isSearching: Bool) {
        self.isSearching = isSearching
    }

    func getSearchResponse(searchRes: [SelectableContact], isSearching: Bool) {
        self.searchRes = searchRes
        self.isSearching = isSearching
    }
}

extension ContactsTableViewDataSource: ContactCollectionViewSelectorDelegate {

    func unselect(_ contact: SelectableContact, in tableView: UITableView) {
        for section in sections {
            section.contacts.forEach { (arContact) in
                if contact.id == arContact.id {
                    contact.isSelected = false
                    print(contact.givenName, contact.isSelected)
                    tableView.reloadData()
                }
            }
        }
    }
}

