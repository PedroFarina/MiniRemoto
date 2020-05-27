//
//  AddGuestsViewController.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class AddGuestsViewController: UIViewController {
    
    @IBOutlet weak var contactsCollectionView: UICollectionView!
    @IBOutlet weak var contactsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: CustomSearchBar!
    
    var tableViewDataSource: ContactsTableViewDataSource?
    var tableViewDelegate: ContactsTableViewDelegate?
    var collectionViewDataSource: ContactsCollectionViewDataSource?
    var collectionViewDelegate: ContactsCollectionViewDelegate?

    let contactsManager = ContactsManager()
    var contacts = [SelectableContact]()
    var searchResp = [SelectableContact]()
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = contactsManager.getSelectableContacts()
        setupCollectionView()
        setupTableView()
        setupSearch()
    }

    func setupSearch() {
        searchBar.setup(contacts: contacts, tableView: contactsTableView)
        searchBar.searchDelegate = tableViewDataSource
    }

    func setupTableView() {
        tableViewDataSource = ContactsTableViewDataSource(contacts: contacts)
        tableViewDelegate = ContactsTableViewDelegate(collectionView: contactsCollectionView, textField: searchBar, sections: tableViewDataSource?.sections ?? [Section]())
        tableViewDelegate?.delegate = collectionViewDataSource
        contactsTableView.dataSource = tableViewDataSource
        contactsTableView.delegate = tableViewDelegate
    }

    func setupCollectionView() {
        collectionViewDataSource = ContactsCollectionViewDataSource(collectionViewHeigh: contactsCollectionViewHeight)
        collectionViewDelegate = ContactsCollectionViewDelegate(tableView: contactsTableView)
        contactsCollectionView.dataSource = collectionViewDataSource
        contactsCollectionView.delegate = collectionViewDelegate
        contactsCollectionViewHeight.constant = 0.0
        collectionViewDelegate?.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension AddGuestsViewController: UnselectContactInTableView {

    func unselect(_ contact: SelectableContact) {
        tableViewDataSource?.unselect(contact)
        collectionViewDataSource?.remove(contact)
        contactsTableView.reloadData()
        contactsCollectionView.reloadData()
    }
}
