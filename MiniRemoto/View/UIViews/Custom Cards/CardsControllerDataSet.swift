//
//  CardsControllerDataSet.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

public protocol CardsControllerDataSource: class {
    func numberOfRows() -> Int
    func cardForIndex(_ index: Int) -> CardView
}
