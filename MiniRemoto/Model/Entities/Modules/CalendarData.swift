//
//  MockupData.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//
import UIKit

public class CalendarData: Module {
    public var addImage: UIImage? = UIImage(named: "CalendarAddModule")
    public var removeImage: UIImage? = UIImage(named: "CalendarRemoveModule")
    public var image: UIImage? = UIImage(named: "CalendarModule")
    public var title: String? = "Data".localized()
    public var subtitle: String? = "Horário".localized()

    private static let hourDF: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat =  "HH:mm"
        return df
    }()
    private static let dateDF: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }()

    public var date: Date? {
        didSet {
            if let date = date {
                title = CalendarData.dateDF.string(from: date)
                subtitle = CalendarData.hourDF.string(from: date)
            } else {
                title = "Data".localized()
                subtitle = "Horário".localized()
            }
        }
    }
}
