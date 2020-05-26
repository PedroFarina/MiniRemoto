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

    var cellIsSelected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(for contact: Contact) {
        let nameInitial = String((contact.givenName).first ?? "A")
        let familyNameInitial = String((contact.familyName).first ?? "A")
        initials.text = nameInitial+familyNameInitial

        contatcName.text = contact.givenName + " " + contact.familyName
        contactEmail.text = contact.email
        purpleView.layer.cornerRadius = self.frame.height/2
    }

    func selectCell() {
        cellIsSelected = !cellIsSelected
        check.image = cellIsSelected ? UIImage(named: "Check") : UIImage(named: "Unselected")
    }
}
