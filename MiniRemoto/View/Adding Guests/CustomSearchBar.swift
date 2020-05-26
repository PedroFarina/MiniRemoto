//
//  CustomSearchBar.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 26/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

protocol GetSearchResponse {
    func getSearchResponse(searchRes: [Contact], isSearching: Bool)
    func changeSearchStatus(isSearching: Bool)
}

class CustomSearchBar: UITextField {

    var tableView: UITableView?
    var searchRes = [Contact]()
    var contacts: [Contact] = []
    var searching: Bool = false
    var searchDelegate: GetSearchResponse?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(contacts: [Contact], tableView: UITableView){
        self.contacts = contacts
        self.tableView = tableView
        self.delegate = self
        self.layer.cornerRadius = self.frame.height/2
    }
}

extension CustomSearchBar: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searching = false
        tableView?.reloadData()
        searchDelegate?.changeSearchStatus(isSearching: searching)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        searching = false
        searchDelegate?.changeSearchStatus(isSearching: searching)
        tableView?.reloadData()
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let searchText = (textField.text ?? "") + string
        searchRes = contacts.filter({ $0.givenName.localizedCaseInsensitiveContains(searchText)})

        if searchRes.count == 0 || searchText == "" {
            searching = false
        } else {
            searching = true
        }

        searchDelegate?.getSearchResponse(searchRes: searchRes, isSearching: searching)
        tableView?.reloadData()
        return true
    }
}
