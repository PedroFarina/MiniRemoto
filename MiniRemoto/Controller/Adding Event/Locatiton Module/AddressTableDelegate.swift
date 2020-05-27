//
//  AddressTableDelegate.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class AddressTableDelegate: NSObject, UITableViewDelegate {
    public var delegate: AddressSelectedDelegate?
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? LocationModuleTableViewCell,
            let item = cell.mapItem {
            delegate?.didSelect(address: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
