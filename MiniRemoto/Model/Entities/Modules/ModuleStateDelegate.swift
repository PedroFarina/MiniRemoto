//
//  ModuleSelectedDelegate.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

public protocol ModuleStateDelegate: class {
    func didAdd(_ module: Module)
    func didRemove(_ module: Module)
}
