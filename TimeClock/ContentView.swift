//
//  ContentView.swift
//  TimeClock
//
//  Created by Kyle Peterson on 11/22/22.
//

import SwiftUI

var user = kylePeterson

var punchIn: Punch? = nil
var lunchOut: Punch? = nil
var lunchIn: Punch? = nil
var punchOut: Punch? = nil

let dateFormatter = DateFormatter()

enum ViewState: String {
    case punchedOut = "punched out",
         punchedIn = "punched in",
         onLunch = "on lunch"
}

struct ContentView: View {
    
    @State private var viewState: ViewState = .punchedOut
    @State private var timeIn = "00:00"
    
    var body: some View {
        
        // PUNCH DEFINITIONS
        let clockInTitle: String = "Clock me in"
        let clockInAction: () -> Void = {
            punchIn = Punch(id: user.id, time: Date(), punchType: .punchIn)
            viewState = .punchedIn
        }
        let lunchOutTitle: String = "Start my lunch"
        let lunchOutAction: () -> Void = {
            lunchOut = Punch(id: user.id, time: Date(), punchType: .lunchOut)
            viewState = .onLunch
        }
        let lunchInTitle: String = "End my lunch"
        let lunchInAction: () -> Void = {
            lunchIn = Punch(id: user.id, time: Date(), punchType: .lunchIn)
            viewState = .punchedIn
        }
        let clockOutTitle: String = "Clock me out"
        let clockOutAction: () -> Void = {
            punchOut = Punch(id: user.id, time: Date(), punchType: .punchOut)
            user.punches.append(punchIn!)
            punchIn = nil
            if lunchOut != nil {
                user.punches.append(lunchOut!)
                lunchOut = nil
            }
            if lunchIn != nil {
                user.punches.append(lunchIn!)
                lunchIn = nil
            }
            user.punches.append(punchOut!)
            punchOut = nil
            viewState = .punchedOut
            dump(user.punches)
        }
        
        // VIEW BODY
        VStack {
            Text("Good morning, \(user.firstName)!")
                .font(.system(.largeTitle))
                .padding()
            if viewState == .punchedOut {
                Text("Would you like to clock in?")
                    .padding(.bottom)
                Button(clockInTitle, action: clockInAction)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .buttonStyle(.bordered)
            } else if viewState == .punchedIn {
                Text("You punched in at \(punchIn?.time ?? Date())")
                    .padding()
                Text("You have been clocked in for \(timeIn) minutes today")
                    .padding()
                if lunchOut == nil {
                    Button(lunchOutTitle, action: lunchOutAction)
                    .padding(.bottom)
                }
                Button(clockOutTitle, action: clockOutAction)
                    .foregroundColor(.pink)
                    
                    .buttonStyle(.bordered)
            } else if viewState == .onLunch {
                
                let timeSinceLunchStarted = Date(timeInterval: .greatestFiniteMagnitude, since: lunchOut!.time)
                
                Text("You have been at lunch for \(timeSinceLunchStarted)")
                    .padding(.bottom)
                
                Button(lunchInTitle, action: lunchInAction)
                .buttonStyle(.bordered)
                .padding(.bottom)
            }
            
            Spacer()
            
            // USER PUNCH MONITOR
            Text("IN: \(punchIn?.time.formatted(date: .long, time: .shortened) ?? "nil")")
            Text("Lunch OUT: \(lunchOut?.time.formatted(date: .long, time: .shortened) ?? "nil")")
            Text("Lunch IN: \(lunchIn?.time.formatted(date: .long, time: .shortened) ?? "nil")")
            Text("OUT: \(punchOut?.time.formatted(date: .long, time: .shortened) ?? "nil")")
            
            Spacer()
            
            PunchHistoryView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
