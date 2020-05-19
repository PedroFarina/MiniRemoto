//
//  AddEventViewController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class AddEventViewController: UIViewController {
    @IBOutlet weak var txtEventName: SlashedTextField!

    @IBOutlet weak var moduleCollectionView: UICollectionView!
    let collectionDelegate = ModuleCollectionViewDelegate()
    let collectionDataSource = ModuleCollectionViewDataSource()
    @IBOutlet weak var moduleTableViewCell: UITableView!
    let tableDelegate = ModuleTableViewDelegate()
    let tableDataSource = ModuleTableViewDataSource()

    public override func viewDidLoad() {

    }

    @IBAction func nextTap(_ sender: Any) {
        //TODO: Next step
        #warning("Next step not implemented yet")
    }
    @IBAction func cancelTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
