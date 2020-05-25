//
//  ModuleTableDataSource.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ModuleTableViewDataSource: NSObject, UITableViewDataSource {

    private var modules: [Module] = []

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let moduleCell = tableView.dequeueReusableCell(withIdentifier: "moduleCell") as? ModuleTableViewCell {
            moduleCell.module = modules[indexPath.row]

            return moduleCell
        }
        return UITableViewCell()
    }

    public func didAdd(_ module: Module) {
        var position: Int = modules.count
        for i in 0 ..< modules.count {
            if type(of: module).preferredRow < type(of: modules[i]).preferredRow {
                position = i
                break
            }
        }
        modules.insert(module, at: position)
    }

    public func didRemove(_ module: Module) {
        if let index = modules.firstIndex(where: { $0.title == module.title }) {
            modules.remove(at: index)
        }
    }
}
