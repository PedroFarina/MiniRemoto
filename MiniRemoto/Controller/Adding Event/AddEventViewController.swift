//
//  AddEventViewController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class AddEventViewController: UIViewController, ModuleStateDelegate, ModuleSelectorDelegate {

    @IBOutlet weak var btnDone: UIButton!
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
        tableDelegate.delegate = self
    }

    public func didAdd(_ module: Module) {
        tableDataSource.didAdd(module)
        reloadData()
    }

    public func didRemove(_ module: Module) {
        tableDataSource.didRemove(module)
        reloadData()
    }

    public func didSelect(_ module: Module) {
        guard type(of: module) == CalendarData.self || type(of: module) == LocationData.self else { return }
        if let controller = UIStoryboard(name: type(of: module).storyboardName, bundle: nil).instantiateViewController(withIdentifier: "main") as? ModuleController {
            controller.module = module
            controller.reloadData = reloadData
            self.present(controller, animated: true)
        }
    }

    private func reloadData() {
        moduleTableView.reloadData()
        var check: Bool = true
        tableDataSource.modules.forEach { (mod) in
            check = check && mod.isFilled()
        }
        if tableDataSource.modules.isEmpty {
            btnDone.isEnabled = false
        } else {
            btnDone.isEnabled = check
        }
    }

    var failAlert: UIAlertController {
        let alert: UIAlertController
        if moduleTableView.visibleCells.count == 0 {
            alert = UIAlertController(title: "Oops!".localized(), message: "Para criar seu evento, é necessário adicionar módulos.".localized(), preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: "Oops!".localized(), message: "Toque nos módulos adicionados para preenchê-los".localized(), preferredStyle: .alert)
        }
        alert.view.tintColor = UIColor(named: "Action Color")

        let action = UIAlertAction(title: "OK".localized(), style: .default)
        alert.addAction(action)
        return alert
    }

    @IBAction func fallbackTap(_ sender: Any) {
        self.present(failAlert, animated: true)
    }
    @IBAction func doneTap(_ sender: Any) {
        //TODO: Save event
        #warning("Save event not implemented yet")
        self.dismiss(animated: true)
    }
    @IBAction func cancelTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
