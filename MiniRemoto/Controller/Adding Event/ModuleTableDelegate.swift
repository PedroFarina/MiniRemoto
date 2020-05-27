//
//  ModuleTableViewController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ModuleTableViewDelegate: NSObject, UITableViewDelegate {

    weak var delegate: ModuleSelectorDelegate?

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let moduleCell = tableView.cellForRow(at: indexPath) as? ModuleTableViewCell,
            let module = moduleCell.module {
            delegate?.didSelect(module)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
