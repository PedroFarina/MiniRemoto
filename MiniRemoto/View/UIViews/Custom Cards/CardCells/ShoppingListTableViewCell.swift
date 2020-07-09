//
//  ShoppingListTableViewCell.swift
//  MiniRemoto
//
//  Created by Felipe Petersen on 28/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import MiniRemotoDatabase

class ShoppingListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shoppingListNameLabel: UILabel!
    @IBOutlet weak var roundedView: RoundView!
    @IBOutlet weak var shoppingListTableView: UITableView!
    
    let MORE_CELL = "MoreTableViewCell"
    let ITEM_CELL = "ItemsListTableViewCell"
    
    let fixCell = 1
//    let contentNumberOfRows = 3
    
    var items = [Item]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupContent()
//        self.setupTableView()
        // Initialization code
    }
    
    func setupTableView() {
        self.shoppingListTableView.delegate = self
        self.shoppingListTableView.dataSource = self
        self.shoppingListTableView.backgroundColor = .clear
        self.shoppingListTableView.isScrollEnabled = false
        self.shoppingListTableView.separatorStyle = .none

        self.shoppingListTableView.register(UINib(nibName: MORE_CELL, bundle: nil), forCellReuseIdentifier: MORE_CELL)
        self.shoppingListTableView.register(UINib(nibName: ITEM_CELL, bundle: nil), forCellReuseIdentifier: ITEM_CELL)

    }
    
    func setupContent() {
        self.roundedView.strokeColor = .black50
        self.shoppingListNameLabel.font = UIFont(name: "Montserrat-Medium", size: 16)
        self.shoppingListNameLabel.textColor = .black50
    }
    
    func setup(shoppingList: [Item]) {
        self.items = shoppingList
        self.setupTableView()
    }
}

extension ShoppingListTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if contentNumberOfRows < 3 {
//            return 2 //Retorna .cont do datasource
//        } else {
        return items.count + fixCell
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.shoppingListTableView.numberOfRows(inSection: 0) - 1 {
            let moreCell = shoppingListTableView.dequeueReusableCell(withIdentifier: MORE_CELL, for: indexPath) as! MoreTableViewCell
            return moreCell
        } else {
            let itemCell = shoppingListTableView.dequeueReusableCell(withIdentifier: ITEM_CELL, for: indexPath) as! ItemsListTableViewCell
            if indexPath.row < items.count {
                itemCell.setup(item: items[indexPath.row])
            }
            return itemCell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
