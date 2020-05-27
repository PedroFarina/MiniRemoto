//
//  AddListTableViewDataSource.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 20/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class AddListTableViewDataSource: NSObject, UITableViewDataSource {

    private var amount = 0
    public var numberOfRows: Int {
        return amount
    }
    var items: [UITextField] = []
    var ADDLISTCELL = "AddListTableViewCell"
    var txtFieldDelegate: UITextFieldDelegate?

    init(txtFieldDelegate: UITextFieldDelegate) {
        self.txtFieldDelegate = txtFieldDelegate
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ADDLISTCELL) as? AddListTableViewCell

        if let delegate = txtFieldDelegate, let cell = cell {
            cell.setup(with: delegate)

            cell.textChanged(action: { (newText) in
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            })

            return cell
        }

        return UITableViewCell()
    }

    func addRow(in tableView: UITableView, at indexPath: IndexPath) {
        tableView.beginUpdates()
        amount += 1
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}
