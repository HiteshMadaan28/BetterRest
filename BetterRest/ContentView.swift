//
//  ContentView.swift
//  BetterRest
//
//  Created by Hitesh Madaan on 07/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount=8.0
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) Hours",value: $sleepAmount,in: 4...12,step: 0.25)
            .padding(40)
            
    }
}

#Preview {
    ContentView()
}
