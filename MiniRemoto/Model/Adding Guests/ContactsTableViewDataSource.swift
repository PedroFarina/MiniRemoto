//
//  ContactsTableViewDataSource.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class ContactsTableViewDataSource: NSObject, UITableViewDataSource {

    let CONTACTSCELL = "ContactsTableViewCell"
    let contacts: [Contact]

    init(contacts: [Contact]) {
        self.contacts = contacts
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CONTACTSCELL) as? ContactsTableViewCell
        cell?.setup(for: contacts[indexPath.row])
        return cell ?? ContactsTableViewCell()
    }
}
