//
//  AddListTableViewDataSource.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 20/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class AddListTableViewDataSource: NSObject, UITableViewDataSource {

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
        return items.count
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

//    func add(item: String, at index: Int) {
//        if items.count == 0 {
//            items.append(item)
//            print(items)
//        } else {
//            items[index-1] = item
//            print(items)
//        }
//    }
}












//
//class AddListTableViewDataSource: NSObject, UITableViewDataSource, ListProtocol {
//
//    var items: [String] = []
//    var ADDLISTCELL = "AddListTableViewCell"
//    var txtFieldDelegate: UITextFieldDelegate?
//
//    init(txtFieldDelegate: UITextFieldDelegate) {
//        self.txtFieldDelegate = txtFieldDelegate
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ADDLISTCELL) as? AddListTableViewCell
//        if let delegate = txtFieldDelegate, let cell = cell {
//            cell.setup(with: delegate)
//            return cell
//        }
//        return UITableViewCell()
//    }
//
//    func add(item: String, in tableView: UITableView, with height: NSLayoutConstraint) {
//        items.append(item)
//        addRow(in: tableView, with: height)
//        print(items)
//    }
//
//    func update(item: String, at index: Int) {
//        items[index] = item
//    }
//
//    func addRow(in tableView: UITableView, with height: NSLayoutConstraint) {
//        let indexPath = IndexPath(row: items.count-1, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
//        height.constant = tableView.contentSize.height
//        tableView.reloadData()
//        tableView.layoutIfNeeded()
//    }
//}
