//
//  AddListTableViewCell.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 20/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class ListModuleTableViewCell: UITableViewCell {

    @IBOutlet weak var txtItem: SlashedTextField!
    var textChanged: ((String) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(with delegate: UITextFieldDelegate) {
        txtItem.delegate = delegate
        txtItem.becomeFirstResponder()
    }

    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }

    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
}
