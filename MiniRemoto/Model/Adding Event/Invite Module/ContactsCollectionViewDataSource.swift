//
//  ContactsCollectionViewDataSource.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class ContactsCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    let CONTACTSCELL = "ContactCollectionViewCell"
    var contacts = [SelectableContact]()
    var collectionViewHeigh: NSLayoutConstraint?

    init(collectionViewHeigh: NSLayoutConstraint) {
        self.collectionViewHeigh = collectionViewHeigh
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CONTACTSCELL, for: indexPath) as? ContactCollectionViewCell
        cell?.contact = contacts[indexPath.row]
        return cell ?? ContactCollectionViewCell()
    }

    func animateCollectionView() {
        if self.contacts.count == 1 {
            UIView.animate(withDuration: 0.3) {
                self.collectionViewHeigh?.constant = 50.0
            }
        } else if self.contacts.count == 0 {
            UIView.animate(withDuration: 0.3) {
                self.collectionViewHeigh?.constant = 0.0
            }
        }
    }
}

extension ContactsCollectionViewDataSource: PassContactFromTableViewToCollectionView {

    func remove(_ contact: SelectableContact) {
        contacts.removeAll { $0.id == contact.id }
        animateCollectionView()
    }

    func pass(_ contact: SelectableContact) {
        contacts.append(contact)
        animateCollectionView()
    }
}
