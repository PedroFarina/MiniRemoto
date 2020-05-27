//
//  ContactsCollectionViewDelegate.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

protocol UnselectContactInTableView {
    func unselect(_ contact: SelectableContact, in tableView: UITableView)
}

class ContactsCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var tableView: UITableView?
    var contacts: [SelectableContact]?
    var delegate: UnselectContactInTableView?

    init(tableView: UITableView, contacts: [SelectableContact]) {
        self.tableView = tableView
        self.contacts = contacts
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let contact = contacts?[indexPath.row], let tableView = tableView else { return }
        delegate?.unselect(contact, in: tableView)
        tableView.reloadData()
    }
}
