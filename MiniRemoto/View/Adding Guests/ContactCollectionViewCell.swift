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

    public var initialsText: String? {
        get {
            return initials.text
        } set {
            initials.text = newValue
        }
    }

    public var contact: Contact? {
        didSet {
            guard let contact = contact else { return }

            let nameInitial = String((contact.givenName).first ?? "A")
            let familyNameInitial = String((contact.familyName).first ?? "A")

            initialsText = nameInitial+familyNameInitial

            purpleView.layer.cornerRadius = self.frame.height/2
        }
    }
}
