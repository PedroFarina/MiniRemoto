//
//  ListModuleTableViewDelegate.swift
//  MiniRemoto
//
//  Created by Eloisa Falcão on 03/06/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class ListModuleTableViewDelegate: NSObject, UITableViewDelegate {

    var view: UIView

    init(view: UIView) {
        self.view = view
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(false)
    }
}
