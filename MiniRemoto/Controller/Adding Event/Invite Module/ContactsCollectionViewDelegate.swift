//
//  ContactsCollectionViewDelegate.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

protocol ContactCollectionViewSelectorDelegate {
    func unselect(_ contact: SelectableContact)
}

class ContactsCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var tableView: UITableView?
    var delegate: ContactCollectionViewSelectorDelegate?

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let cell = collectionView.cellForItem(at: indexPath) as? ContactCollectionViewCell, let contact = cell.contact {
            delegate?.unselect(contact)
        }
    }
}
