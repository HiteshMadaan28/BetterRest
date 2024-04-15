//
//  ContentView.swift
//  BetterRest
//
//  Created by Hitesh Madaan on 07/04/24.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultTime
    @State private var sleepAmount = 8.0
    @State private var coffeecups=0
    
    @State private var alertTitle=""
    @State private var alertMessage=""
    @State private var showingAlert=false
    
    var result:String{
        var sleepTime:Date
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components=Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            
            let hour=(components.hour ?? 0) * 60 * 60
            let minute=(components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeecups)))
            
            sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted,time: .shortened)
            
        }catch{
            
        }
        
        return ""
    }
    
    static var defaultTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var body: some View {
        
        NavigationStack{
            ZStack{
            LinearGradient(colors: [.blue , .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                VStack(spacing: 10){
                  
                    Text("When do you want to Wake up")
                        .font(.headline)
                    
                    DatePicker("Please Enter a time",selection: $wakeUp,displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Spacer()
                
                VStack(alignment: .leading,spacing: 10){
                    Text("Desired Amount of Sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours",value: $sleepAmount,in: 4...12,step: 0.25)
                        .frame(width: 200)
                }
                
                Spacer()
                
                VStack(alignment: .leading,spacing: 10){
                    Text("Daily coffee Intake")
                        .font(.headline)
                    
                    Stepper("\(coffeecups) cup(s))",value: $coffeecups,in: 0...20)
                        .frame(width: 200)
                }
                Spacer()
                Section("Esstimate BedTime"){
                    Text("\(result)")
                        .font(.largeTitle.bold())
                Spacer()
                }
            
            }
            .frame(width: 300,height:500)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
            
            
            
            .navigationTitle("BetterRest")
//            .toolbar{
//                Button("Calculate",action: calculateBedTime)
//            }
        }.alert(alertTitle,isPresented: $showingAlert){
            Button("OK"){}
            
        }message: {
            Text(alertMessage)
        }
            }
        
    }
    
    func calculateBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components=Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            
            let hour=(components.hour ?? 0) * 60 * 60
            let minute=(components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeecups)))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal BedTime is..."
            alertMessage = sleepTime.formatted(date: .omitted,time: .shortened)
        }
        catch{
            
            alertTitle="Error"
            alertMessage="Sorry , there is an proble while calculating your bedtime"
            
        }
        
        showingAlert=true
    }
}

#Preview {
    ContentView()
}
