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
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: CustomSearchBar!
    
    var tableViewDataSource: ContactsTableViewDataSource?
    var tableViewDelegate: ContactsTableViewDelegate?
    var collectionViewDataSource: ContactsCollectionViewDataSource?
    var collectionViewDelegate: ContactsCollectionViewDelegate?

    let contactsController = ContactsController()
    var contacts = [Contact]()
    var searchResp = [Contact]()
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContacts()
        setup()
        searchBar.setup(contacts: contacts, tableView: contactsTableView)
        searchBar.searchDelegate = tableViewDataSource
    }
    
    func setupContacts()  {
        contactsController.requestAccess()
        contacts = contactsController.getContacts()
    }
    
    func setup() {
        tableViewDataSource = ContactsTableViewDataSource(contacts: contacts)

        let sessions = tableViewDataSource?.getSections()
        tableViewDelegate = ContactsTableViewDelegate(sections: sessions ?? [], collectionView: contactsCollectionView, textField: searchBar)

        collectionViewDataSource = ContactsCollectionViewDataSource()
        collectionViewDelegate = ContactsCollectionViewDelegate(sections: sessions ?? [], tableView: contactsTableView)

        tableViewDelegate?.delegate = collectionViewDataSource

        contactsTableView.dataSource = tableViewDataSource
        contactsTableView.delegate = tableViewDelegate

        contactsCollectionView.dataSource = collectionViewDataSource
        contactsCollectionView.delegate = collectionViewDelegate
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
