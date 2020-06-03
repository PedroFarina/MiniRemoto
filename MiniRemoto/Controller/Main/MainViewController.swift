//
//  MainViewController.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 25/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import MiniRemotoDatabase

public class MainViewController: UIViewController, CardsControllerDataSource, DBObserver, DBErrorDelegate {
    public func didUpdateData() {
        DispatchQueue.main.async {
            self.events.reloadData()
        }
    }

    public func didOccur(_ error: Error) {
        if let err = error as? ResponseError {
            print(err.description)
        } else {
            print(error.localizedDescription)
        }
    }

    @IBOutlet weak var events: CardsController!

    public override func viewDidLoad() {
        events.dataSource = self
        DataController.shared().registerAsObserver(self)
        DataController.shared().delegate = self
        DataController.shared().createUser()
    }
    deinit {
        DataController.shared().removeAsObserver(self)
    }

    public func numberOfRows() -> Int {
        return DataController.shared().events.count
    }

    public func cardForIndex(_ index: Int) -> CardView {
        let card = CardView()
        card.event = DataController.shared().events[index]
//        if let color = DataController.shared().events[index].event?.color,
//            let colorEnum = AppColor(rawValue: color) {
//            card.fillColor = .getColorFrom(colorEnum)
//        } else {
//            card.fillColor = .random()
//        }
//        card.detail = DataController.shared().events[index].event?.startHour
//        card.title = DataController.shared().events[index].event?.name
        return card
    }
}


public extension UIColor {
    static func random() -> UIColor {
        return .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
    }
}
