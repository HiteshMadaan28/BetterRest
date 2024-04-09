//
//  ContentView.swift
//  BetterRest
//
//  Created by Hitesh Madaan on 07/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    
    var body: some View {
        
        DatePicker("Please Enter the Date",selection: $wakeUp,in: Date.now...)
            .labelsHidden()
        
        Stepper("\(sleepAmount.formatted()) Hours",value: $sleepAmount,in: 4...12,step: 0.25)
            .padding(40)
            
    }
    
    func exampleDate(){
        
        let tomorrow=Date.now.addingTimeInterval(86400)
        let range=Date.now...tomorrow
    }
}

#Preview {
    ContentView()
}
