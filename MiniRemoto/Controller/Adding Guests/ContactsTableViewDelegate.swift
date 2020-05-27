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

    init(collectionView: UICollectionView, textField: CustomSearchBar) {
        self.collectionView = collectionView
        self.textField = textField
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let cellForRow = tableView.cellForRow(at: indexPath) as? ContactsTableViewCell
        guard let cell = cellForRow, var contact = cell.contact else { return }

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

