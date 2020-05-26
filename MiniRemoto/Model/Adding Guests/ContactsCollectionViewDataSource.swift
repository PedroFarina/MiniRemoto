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
    var contacts = [Contact]()

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CONTACTSCELL, for: indexPath) as? ContactCollectionViewCell
        cell?.setup(for: contacts[indexPath.row])
        return cell ?? ContactCollectionViewCell()
    }
}

extension ContactsCollectionViewDataSource: PassContactThroughDataSourcesDelegate {

    func remove(_ contact: Contact) {
        contacts.removeAll { $0.id == contact.id }
    }

    func pass(_ contact: Contact) {
        contacts.append(contact)
        print(contacts)
    }
}
