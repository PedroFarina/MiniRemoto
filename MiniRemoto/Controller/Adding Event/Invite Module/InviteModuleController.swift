//
//  AddGuestsViewController.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class InviteModuleController: UIViewController, ModuleController {
    
    var module: Module?
    var reloadData: (() -> Void)?
    
    @IBOutlet weak var contactsCollectionView: UICollectionView!
    @IBOutlet weak var contactsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: CustomSearchBar!
    @IBOutlet weak var save: UIButton!

    private func checkSave() {

        if returnGuestsIds().count == 0 {
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
        guard let inviteModule = module as? InviteData, let ids = inviteModule.guestsIds else { return }

        for id in ids {
            contacts.forEach { (contact) in
                if contact.id == id {
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

    func returnGuestsIds() -> [String] {
        var ids: [String] = []

        contacts.forEach { (contact) in
            if contact.isSelected == true {
                ids.append(contact.id)
            }
        }

        return ids
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

        data.guestsIds = returnGuestsIds()

        reloadData?()
        self.dismiss(animated: true)
    }
}

extension InviteModuleController: UnselectContactInTableView {
    
    func unselect(_ contact: SelectableContact) {
        tableViewDataSource?.unselect(contact)
        collectionViewDataSource?.remove(contact)
        contactsTableView.reloadData()
        contactsCollectionView.reloadData()
        checkSave()
    }
}
