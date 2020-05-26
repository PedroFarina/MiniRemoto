//
//  ContactsTableViewDelegate.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

protocol PassContactFromTableViewToCollectionView {
    func pass(_ contact: Contact)
    func remove(_ contact: Contact)
}

class ContactsTableViewDelegate: NSObject, UITableViewDelegate {

    var sections: [Section]
    var searchResp: [Contact] = []
    var isSearching: Bool = false

    var delegate: PassContactFromTableViewToCollectionView?
    var collectionView: UICollectionView?
    var textField: CustomSearchBar?


    init(sections: [Section], collectionView: UICollectionView, textField: CustomSearchBar) {
        self.collectionView = collectionView
        self.sections = sections
        self.textField = textField
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkIfSelectionIsAvaliable(for: indexPath, in: tableView)
        tableView.reloadData()
        collectionView?.reloadData()
        textField?.resignFirstResponder()
    }

    func checkIfSelectionIsAvaliable(for indexPath: IndexPath, in tableView: UITableView) {

        let cellForRow = tableView.cellForRow(at: indexPath) as? ContactsTableViewCell
        guard let cell = cellForRow else { return }

        if isSearching {
            checkIfCellIsSelected(indexPath: indexPath, cell: cell, contacts: searchResp)
        } else {
            let section = sections[indexPath.section]
            checkIfCellIsSelected(indexPath: indexPath, cell: cell, contacts: section.contacts)
        }
    }

    func checkIfCellIsSelected(indexPath: IndexPath, cell: ContactsTableViewCell, contacts: [Contact] ) {
        if cell.cellIsSelected == true {
            cell.selectCell()
            delegate?.remove(contacts[indexPath.row])
        } else {
            cell.selectCell()
            delegate?.pass(contacts[indexPath.row])
        }
    }
}

extension ContactsTableViewDelegate: PassSearchResponse {
    func getSearchResponse(searchRes: [Contact], isSearching: Bool) {
        searchResp = searchRes
        self.isSearching = isSearching
    }
}
