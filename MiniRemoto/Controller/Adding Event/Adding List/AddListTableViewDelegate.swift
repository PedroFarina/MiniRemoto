//
//  AddListTableViewDelegate.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 20/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class AddListTableViewDelegate: NSObject, UITableViewDelegate {

    var lastIndexPathRow: Int = 0
    var tableViewHeight: NSLayoutConstraint?

    init(tableViewHeight: NSLayoutConstraint) {
        self.tableViewHeight = tableViewHeight
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 28
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

//class AddListTableViewDelegate: NSObject, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 28
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return CGFloat.leastNormalMagnitude
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("tap")
//    }
//
//    func addRow(in tableView: UITableView, with height: NSLayoutConstraint) {
//        let indexPath = IndexPath(row: items.count-1, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
//        height.constant = tableView.contentSize.height
//        tableView.reloadData()
//        tableView.layoutIfNeeded()
//    }
//
//}
