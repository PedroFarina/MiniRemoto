//
//  DBDidChange.swift
//  MiniRemotoDatabase
//
//  Created by Pedro Giuliano Farina on 02/06/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

public protocol DBObserver: class {
    func didUpdateData()
}
