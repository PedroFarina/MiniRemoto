//
//  MainViewController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

public class MainViewController: UIViewController, CardsControllerDataSource {
    @IBOutlet weak var events: CardsController!

    public override func viewDidLoad() {
        events.dataSource = self
    }

    public func numberOfRows() -> Int {
        return 10
    }

    public func cardForIndex(_ index: Int) -> CardView {
        let card = CardView()
        card.fillColor = .random()
        card.detail = "13:00"
        card.title = "Festa \(index + 1)"
        card.subtitle = "Farina"
        return card
    }
}


public extension UIColor {
    static func random() -> UIColor {
        return .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}
