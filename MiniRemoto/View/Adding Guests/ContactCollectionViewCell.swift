//
//  ContactCollectionViewCell.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var initials: UILabel!

    func setup(for contact: Contact) {

        let nameInitial = String((contact.givenName).first ?? "A")
        let familyNameInitial = String((contact.familyName).first ?? "A")
        initials.text = nameInitial+familyNameInitial

        purpleView.layer.cornerRadius = self.frame.height/2
    }
}
