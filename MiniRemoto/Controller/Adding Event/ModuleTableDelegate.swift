//
//  ModuleTableViewController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ModuleTableViewDelegate: NSObject, UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let moduleCell = tableView.cellForRow(at: indexPath) as? ModuleTableViewCell,
            let module = moduleCell.module {
            //TODO: Abrir o modal do módulo selecionado e passar ele pra próxima tela preencher
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
