//
//  ListData.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class ListData: Module {
    public static let storyboardName: String = "ListModule"
    public static let preferredRow: Int = 3
    public var addImage: UIImage? = UIImage(named: "ListAddModule")
    public var removeImage: UIImage? = UIImage(named: "ListRemoveModule")
    public var image: UIImage? = UIImage(named: "ListModule")
    public var title: String? = "Lista de compras".localized()
    public var subtitle: String?

    public func isFilled() -> Bool {
        return false
    }
}
