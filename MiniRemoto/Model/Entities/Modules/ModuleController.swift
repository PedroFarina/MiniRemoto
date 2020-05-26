//
//  ModuleController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 26/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public protocol ModuleController: UIViewController {
    var module: Module? { get set }
    var tableView: UITableView? { get set }
}
