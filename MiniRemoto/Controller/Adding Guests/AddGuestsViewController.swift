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

    var tableViewDataSource: ContactsTableViewDataSource?
    var tableViewDelegate: ContactsTableViewDelegate?
    var collectionViewDataSource: ContactsCollectionViewDataSource?
    var collectionViewDelegate: ContactsCollectionViewDelegate?

    let contactsController = ContactsController()
    var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContacts()
        setup()
    }
    
    func setupContacts()  {
        contactsController.requestAccess()
        contacts = contactsController.getContacts()
    }
    
    func setup() {
        tableViewDataSource = ContactsTableViewDataSource(contacts: contacts)
        tableViewDelegate = ContactsTableViewDelegate(contacts: contacts, collectionView: contactsCollectionView)

        collectionViewDataSource = ContactsCollectionViewDataSource()
        collectionViewDelegate = ContactsCollectionViewDelegate()

        tableViewDelegate?.delegate = collectionViewDataSource

        contactsTableView.dataSource = tableViewDataSource
        contactsTableView.delegate = tableViewDelegate

        contactsCollectionView.dataSource = collectionViewDataSource
        contactsCollectionView.delegate = collectionViewDelegate

        contactsTableView.reloadData()
        contactsCollectionView.reloadData()
    }
}
