//
//  AddListViewController.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 20/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class ListModuleViewController: UIViewController, ModuleController {

    var module: Module?
    var reloadData: (() -> Void)?

    @IBOutlet weak var placeHolderAddListTip: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var tbBottomConstraint: NSLayoutConstraint!
    var shouldBeginCalledBeforeHand: Bool = false

    var texts: [String] = []
    var rows: Int = 0
    let identifier: String = "AddListTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource = self
        listTableView.delegate = self
    }

    @IBAction func addItemButton(_ sender: Any) {
        addRow()
    }
    
    @IBAction func confirmarButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    func addRow() {
        texts.append("")
        listTableView.reloadData()
    }
}

extension ListModuleViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellForRow = tableView.dequeueReusableCell(withIdentifier: identifier) as? ListModuleTableViewCell

        guard let cell = cellForRow else { return UITableViewCell() }
        cell.setup(with: self)
        return cell
    }
}

extension ListModuleViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addRow()
        return false
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        shouldBeginCalledBeforeHand = true
        return shouldBeginCalledBeforeHand
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return shouldBeginCalledBeforeHand
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        shouldBeginCalledBeforeHand = false
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        shouldBeginCalledBeforeHand = false
        view.endEditing(true)
    }
}
