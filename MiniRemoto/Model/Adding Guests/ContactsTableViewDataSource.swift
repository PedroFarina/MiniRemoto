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
    var contacts: [Contact]
}

class ContactsTableViewDataSource: NSObject, UITableViewDataSource {

    let CONTACTSCELL = "ContactsTableViewCell"
    var contacts: [Contact]
    var searchResp: [Contact] = []
    var sections = [Section]()
    var isSearching: Bool = false
    let alphabet = ["A", "B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

    init(contacts: [Contact]) {
        self.contacts = contacts
        super.init()
        setupSections()
    }

    func getSections() -> [Section]{
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

    func groupBy(letter: String) -> [Contact] {
        var alphabeticalGroup: [Contact] = []
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
            return searchResp.count
        case false:
            let contacts = sections[section].contacts
            return contacts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CONTACTSCELL) as? ContactsTableViewCell

        switch isSearching {
        case true:
            cell?.setup(for: searchResp[indexPath.row])
        case false:
            let contacts = sections[indexPath.section].contacts
            cell?.setup(for: contacts[indexPath.row])
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
}

extension ContactsTableViewDataSource: GetSearchResponse {

    func changeSearchStatus(isSearching: Bool) {
        self.isSearching = isSearching
        print(self.isSearching)
    }

    func getSearchResponse(searchRes: [Contact], isSearching: Bool) {
        searchResp = searchRes
        self.isSearching = isSearching
        print(self.isSearching)
    }
}

