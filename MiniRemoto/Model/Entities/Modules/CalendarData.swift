//
//  MockupData.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//
import UIKit

public class CalendarData: Module {
    public static let storyboardName: String = "CalendarModule"
    public static let preferredRow: Int = 0
    public var addImage: UIImage? = UIImage(named: "CalendarAddModule")
    public var removeImage: UIImage? = UIImage(named: "CalendarRemoveModule")
    public var image: UIImage? = UIImage(named: "CalendarModule")
    public var title: String? = "Data".localized()
    public var subtitle: String? = "Horário".localized()

    public func isFilled() -> Bool {
        return startDate != nil
    }

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

    public var startDate: Date? {
        didSet {
            if let date = startDate {
                title = CalendarData.dateDF.string(from: date)
                if allDay {
                    subtitle = "Dia todo".localized()
                } else  {
                    subtitle = CalendarData.hourDF.string(from: date)
                }
            } else {
                title = "Data".localized()
                subtitle = "Horário".localized()
            }
        }
    }
    public var endDate: Date?
    public var allDay: Bool = false
}
