//
//  ContactsTableViewCell.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var initials: UILabel!
    @IBOutlet weak var contatcName: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var check: UIImageView!

    public var initialsText: String? {
        get {
            return initials.text
        } set {
            initials.text = newValue
        }
    }

    public var name: String? {
        get {
            return contatcName.text
        }
        set {
            contatcName.text = newValue
        }
    }

    public var email: String? {
        get {
            return contactEmail.text
        }
        set {
            contactEmail.text = newValue
        }
    }

    public var contact: Contact? {
        didSet {
            guard let contact = contact else { return }

            let nameInitial = String((contact.givenName).first ?? "A")
            let familyNameInitial = String((contact.familyName).first ?? "A")

            initialsText = nameInitial + familyNameInitial
            email = contact.email
            name = contact.givenName + " " + contact.familyName

            purpleView.layer.cornerRadius = self.frame.height/2
        }
    }

    var cellIsSelected: Bool {
        return check.image == UIImage(named: "Check")
    }

    func selectCell() {
        check.image = cellIsSelected ? UIImage(named: "Unselected") :  UIImage(named: "Check")
    }
}
