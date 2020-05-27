//
//  StringExtension.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

public extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    func localized(with comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
