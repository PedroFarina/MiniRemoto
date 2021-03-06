//
//  InviteData.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class InviteData: Module {

    public static let storyboardName: String = "InviteModule"
    public static let preferredRow: Int = 2
    public var addImage: UIImage? = UIImage(named: "InviteAddModule")
    public var removeImage: UIImage? = UIImage(named: "InviteRemoveModule")
    public var image: UIImage? = UIImage(named: "InviteModule")
    public var title: String? = "Convidados".localized()
    public var subtitle: String?

    public func isFilled() -> Bool {
        return guests != nil
    }

    public var guests: [SelectableContact]? {
        didSet {
            if guests?.count==1 {
                title = "1 " + "Convidado".localized()
            } else {
                title = "\(guests?.count ?? 0) " + "Convidados".localized()
            }
        }
    }
}
