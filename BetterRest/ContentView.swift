//
//  ContentView.swift
//  BetterRest
//
//  Created by Hitesh Madaan on 07/04/24.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeecups=0
    
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("When do you want to Wake up")
                    .font(.headline)
                
                DatePicker("Please Enter a time",selection: $wakeUp,displayedComponents: .hourAndMinute)
                    .labelsHidden()
                Text("Desired Amount of Sleep")
                    .font(.headline)
                
                Stepper("\(sleepAmount.formatted()) hours",value: $sleepAmount,in: 4...12,step: 0.25)
                    .frame(width: 200)
                
                Text("Daily coffee Intake")
                    .font(.headline)
                
                Stepper("\(coffeecups) cup(s))",value: $coffeecups,in: 0...20)
                    .frame(width: 200)
            }
            .navigationTitle("BetterRest")
            .toolbar{
                Button("Calculate",action: calculateBedTime)
            }
        }
        
    }
    
    func calculateBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
        }
        catch{
            
        }
    }
}

#Preview {
    ContentView()
}
