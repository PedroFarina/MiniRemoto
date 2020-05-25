//
//  AddListViewController.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 20/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class AddListViewController: UIViewController {

    @IBOutlet weak var txtListName: SlashedTextField!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    var addListTableViewDataSource: AddListTableViewDataSource?
    var addListTableViewDelegate: AddListTableViewDelegate?
    var shouldBeginCalledBeforeHand: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        hideKeyboardWhenTappedAround()
    }

    func setupTableView() {
        addListTableViewDataSource = AddListTableViewDataSource(txtFieldDelegate: self)
        addListTableViewDelegate = AddListTableViewDelegate(tableViewHeight: tableViewHeight)
        listTableView.dataSource = addListTableViewDataSource
        listTableView.delegate = addListTableViewDelegate
    }

    func addRow(item: String) {
        guard let row = addListTableViewDelegate?.getLastIndexPathRow() else { return }
        print(row)
        addListTableViewDataSource?.add(item: item, at: row)
        addListTableViewDelegate?.addRow(tableView: listTableView, in: row)
    }

    @IBAction func addItemButton(_ sender: Any) {
        addRow(item: "")
    }
}

extension AddListViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addListTableViewDelegate?.updateLastIndexPathRow()
        listTableView.reloadData()
        addRow(item: textField.text ?? "")
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
        shouldBeginCalledBeforeHand = true
        view.endEditing(true)
    }
}

//protocol ListProtocol {
//    func add(item: String, in tableView: UITableView, with height: NSLayoutConstraint)
//}
//
//class AddListViewController: UIViewController {
//
//    @IBOutlet weak var txtListName: SlashedTextField!
//    @IBOutlet weak var listTableView: UITableView!
//    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
//
//    var addListTableViewDataSource: AddListTableViewDataSource?
//    let addListTableViewDelegate = AddListTableViewDelegate()
//    var shouldBeginCalledBeforeHand: Bool = false
//    var listProtocol: ListProtocol?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTableView()
//        hideKeyboardWhenTappedAround()
//    }
//
//    func setupTableView() {
//        addListTableViewDataSource = AddListTableViewDataSource(txtFieldDelegate: self)
//        listTableView.dataSource = addListTableViewDataSource
//        listTableView.delegate = addListTableViewDelegate
//        listProtocol = addListTableViewDataSource
//    }
//
//    func addRow(item: String) {
//        listProtocol?.add(item: item, in: listTableView, with: tableViewHeight)
//    }
//
//    @IBAction func addItemButton(_ sender: Any) {
//        addRow(item: "")
//    }
//}
//
//extension AddListViewController: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        addRow(item: textField.text ?? "")
//        return false
//    }
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        shouldBeginCalledBeforeHand = true
//        return shouldBeginCalledBeforeHand
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        return shouldBeginCalledBeforeHand
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        shouldBeginCalledBeforeHand = false
//    }
//
//    func hideKeyboardWhenTappedAround() {
//          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//          tap.cancelsTouchesInView = false
//          view.addGestureRecognizer(tap)
//      }
//
//     @objc func dismissKeyboard() {
//          shouldBeginCalledBeforeHand = true
//          view.endEditing(true)
//      }
//}
