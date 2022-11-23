//
//  UserModel.swift
//  TimeClock
//
//  Created by Kyle Peterson on 11/22/22.
//

import Foundation

struct User {
    let id: UUID = UUID()
    let firstName: String
    let lastName: String
    var punches: [Punch]
}
