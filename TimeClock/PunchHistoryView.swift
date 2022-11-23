//
//  PunchHistoryView.swift
//  TimeClock
//
//  Created by Kyle Peterson on 11/23/22.
//

import SwiftUI

struct PunchHistoryView: View {
    
    var user = kylePeterson
    
    var body: some View {
        ForEach (user.punches, id: \.self) { punch in
            Text("\(punch.punchType.rawValue): \(punch.time.formatted(date: .long, time: .shortened))")
            
        }
    }
}

struct PunchHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PunchHistoryView()
    }
}
