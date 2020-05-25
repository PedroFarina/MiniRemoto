//
//  MockupData.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 19/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

public class MockUpData {
    private init() {
    }
    public static let calendarModule: CalendarModule = {
        let calendar = CalendarModule()
        #if !DEBUG
        #error("This class must not exist in production")
        #endif
        return calendar
    }()
}

import UIKit

public class CalendarModule: Module {
    
    public var addImage: UIImage? = UIImage(named: "CalendarAddModule")

    public var removeImage: UIImage? = UIImage(named: "CalendarRemoveModule")

    public var image: UIImage? = UIImage(named: "CalendarModule")

    public var title: String? = "Data"

    public var subtitle: String? = "Horário"
}
