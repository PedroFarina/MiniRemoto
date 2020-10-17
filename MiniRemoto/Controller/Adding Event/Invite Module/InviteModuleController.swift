//
//  AddGuestsViewController.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class InviteModuleController: UIViewController, ModuleController, ContactTableViewSelectorDelegate  {
    
    var module: Module?
    var reloadData: (() -> Void)?
    
    @IBOutlet weak var contactsCollectionView: UICollectionView!
    @IBOutlet weak var contactsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var save: UIButton!

    private func checkSave() {
        if returnGuests().count == 0 {
            save.isEnabled = false
        } else {
            save.isEnabled = true
        }
    }
    
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
        setupModule()
        checkSave()
    }

    func setupModule() {
        guard let inviteModule = module as? InviteData, let guests = inviteModule.guests else { return }

        for guest in guests {
            contacts.forEach { (contact) in
                if contact.id == guest.id {
                    contact.isSelected = true
                }
            }
        }
        checkSave()
    }
    
    func setupSearch() {
        searchBar.setup(contacts: contacts, tableView: contactsTableView)
        searchBar.searchDelegate = tableViewDataSource
    }
    
    func setupTableView() {
        tableViewDataSource = ContactsTableViewDataSource(contacts: contacts)
        tableViewDelegate = ContactsTableViewDelegate(collectionView: contactsCollectionView, textField: searchBar, sections: tableViewDataSource?.sections ?? [Section]())
        tableViewDelegate?.delegate = self
        contactsTableView.dataSource = tableViewDataSource
        contactsTableView.delegate = tableViewDelegate

        contactsTableView.tableFooterView = UIView()
        contactsTableView.backgroundColor = .systemBackground
    }
    
    func setupCollectionView() {
        collectionViewDataSource = ContactsCollectionViewDataSource(collectionViewHeigh: contactsCollectionViewHeight)
        collectionViewDelegate = ContactsCollectionViewDelegate(tableView: contactsTableView)
        contactsCollectionView.dataSource = collectionViewDataSource
        contactsCollectionView.delegate = collectionViewDelegate
        contactsCollectionViewHeight.constant = 0.0
        collectionViewDelegate?.delegate = self
    }

    func didSelect(_ contact: SelectableContact) {
        checkSave()
        collectionViewDataSource?.add(contact)
    }

    func didUnselect(_ contact: SelectableContact) {
        checkSave()
        collectionViewDataSource?.remove(contact)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func returnGuests() -> [SelectableContact] {
        var guests: [SelectableContact] = []

        contacts.forEach { (contact) in
            if contact.isSelected == true {
                guests.append(contact)
            }
        }

        return guests
    }

    func setGuestsSelection() {
        contacts.forEach { (contact) in
            if contact.isSelected == true {
                contact.isSelected = false
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
        setGuestsSelection()
    }
    
    @IBAction func saveData(_ sender: Any) {
        guard let data = module as? InviteData else {
            fatalError("Module was not InviteData")
        }

        data.guests = returnGuests()

        reloadData?()
        self.dismiss(animated: true)
    }
}

extension InviteModuleController: ContactCollectionViewSelectorDelegate {
    
    func unselect(_ contact: SelectableContact) {
        tableViewDataSource?.unselect(contact)
        collectionViewDataSource?.remove(contact)
        contactsTableView.reloadData()
        contactsCollectionView.reloadData()
        checkSave()
    }
}
