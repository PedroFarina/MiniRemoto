//
//  ContactsTableViewDelegate.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

protocol PassContactThroughDataSourcesDelegate {
    func pass(_ contact: Contact)
}

class ContactsTableViewDelegate: NSObject, UITableViewDelegate {

    let contacts: [Contact]
    var delegate: PassContactThroughDataSourcesDelegate?
    var collectionView: UICollectionView?

    init(contacts: [Contact], collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.contacts = contacts
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.pass(contacts[indexPath.row])
        collectionView?.reloadData()
    }
}
