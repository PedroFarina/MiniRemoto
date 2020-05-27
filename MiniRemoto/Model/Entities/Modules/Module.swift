//
//  Module.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public protocol Module: class {
    var addImage: UIImage? { get }
    var removeImage: UIImage? { get }
    var image: UIImage? { get }
    var title: String? { get }
    var subtitle: String? { get }

    func isFilled() -> Bool

    static var preferredRow: Int { get }
    static var storyboardName: String { get }
}
