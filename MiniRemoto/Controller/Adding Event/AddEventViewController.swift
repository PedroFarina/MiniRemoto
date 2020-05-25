//
//  AddEventViewController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class AddEventViewController: UIViewController, ModuleStateDelegate {

    @IBOutlet weak var txtEventName: SlashedTextField!
    @IBOutlet weak var moduleCollectionView: UICollectionView!
    let collectionDelegate = ModuleCollectionViewDelegate()
    let collectionDataSource = ModuleCollectionViewDataSource()
    @IBOutlet weak var moduleTableView: UITableView!
    let tableDelegate = ModuleTableViewDelegate()
    let tableDataSource = ModuleTableViewDataSource()

    public override func viewDidLoad() {
        moduleCollectionView.delegate = collectionDelegate
        moduleCollectionView.dataSource = collectionDataSource
        moduleTableView.delegate = tableDelegate
        moduleTableView.dataSource = tableDataSource
        
        moduleTableView.tableFooterView = UIView()
        collectionDelegate.delegate = self
    }

    public func didAdd(_ module: Module) {
        tableDataSource.didAdd(module)
        moduleTableView.reloadData()
    }

    public func didRemove(_ module: Module) {
        tableDataSource.didRemove(module)
        moduleTableView.reloadData()
    }

    @IBAction func nextTap(_ sender: Any) {
        //TODO: Next step
        #warning("Next step not implemented yet")
    }
    @IBAction func cancelTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
