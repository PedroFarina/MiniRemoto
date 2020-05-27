//
//  ContactsTableViewDelegate.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

protocol PassContactFromTableViewToCollectionView {
    func pass(_ contact: SelectableContact)
    func remove(_ contact: SelectableContact)
}

class ContactsTableViewDelegate: NSObject, UITableViewDelegate {

    var delegate: PassContactFromTableViewToCollectionView?
    var collectionView: UICollectionView?
    var textField: CustomSearchBar?
    var sections: [Section]?

    init(collectionView: UICollectionView, textField: CustomSearchBar, sections: [Section]) {
        self.collectionView = collectionView
        self.textField = textField
        self.sections = sections
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let contacts = sections?[section].contacts

        if contacts?.count == 0 {
            return 0
        } else {
            return 23
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cellForRow = tableView.cellForRow(at: indexPath) as? ContactsTableViewCell
        guard let cell = cellForRow, let contact = cell.contact else { return }

        if contact.isSelected == true {
            contact.isSelected = false
            cell.selectCheckImage(isSelected: false)
            delegate?.remove(contact)

        } else {
            contact.isSelected = true
            cell.selectCheckImage(isSelected: true)
            delegate?.pass(contact)
        }

        tableView.reloadData()
        collectionView?.reloadData()
        textField?.resignFirstResponder()
    }
}

