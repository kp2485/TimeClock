//
//  PunchModel.swift
//  TimeClock
//
//  Created by Kyle Peterson on 11/22/22.
//

import Foundation
import CoreLocation

struct Punch: Hashable {
    var id: UUID
    var time: Date
    enum PunchType: String {
        case punchIn = "Punch In",
             lunchOut = "Lunch Out",
             lunchIn = "Lunch In",
             punchOut = "Punch Out"
    }
    var punchType: PunchType
}
