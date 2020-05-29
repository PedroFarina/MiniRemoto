//
//  CustomSearchBar.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 26/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

protocol GetSearchResponse {
    func getSearchResponse(searchRes: [SelectableContact], isSearching: Bool)
    func changeSearchStatus(isSearching: Bool)
}

@IBDesignable class CustomSearchBar: UITextField {

    @IBInspectable public var radius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }

    var tableView: UITableView?
    var searchRes = [SelectableContact]()
    var contacts: [SelectableContact] = []
    var searching: Bool = false
    var searchDelegate: GetSearchResponse?
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup(contacts: [SelectableContact], tableView: UITableView){
        self.contacts = contacts
        self.tableView = tableView
        self.delegate = self
        self.layer.cornerRadius = self.frame.height/2
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
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
        searchRes = contacts.filter({ $0.givenName.localizedCaseInsensitiveContains(searchText) || $0.familyName.localizedCaseInsensitiveContains(searchText) })

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
