//
//  ContentView.swift
//  UnitConversions
//
//  Created by Anastasiia Solomka on 03.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    @State private var inputMeasurementType = "Seconds"
    @State private var outputMeasurementType = "Minutes"
    @FocusState private var inputValueIsFocused: Bool
    
    var measurementTypes = ["Seconds", "Minutes", "Hours", "Days"]
    
    var inputInSeconds: Double {
        inputValue
    }
    
    var inputConvector: Double {
        var calculatedValue = 0.0
        
        switch inputMeasurementType {
        case "Minutes":
            calculatedValue = inputInSeconds * 60
        case "Hours":
            calculatedValue = inputInSeconds * 60 * 60
        case "Days":
            calculatedValue = inputInSeconds * 60 * 60 * 24
        default:
            calculatedValue = inputInSeconds
        }
        return calculatedValue
    }
    
    var convertedValue: Double {
        var calculatedValue = 0.0
        
        switch outputMeasurementType {
        case "Minutes":
            calculatedValue = inputConvector / 60
        case "Hours":
            calculatedValue = inputConvector / (60 * 60)
        case "Days":
            calculatedValue = inputConvector / (60 * 60 * 24)
        default:
            calculatedValue = inputConvector
        }
        return calculatedValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter time value...", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputValueIsFocused)
                    Picker ("From", selection: $inputMeasurementType) {
                        ForEach(measurementTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Time value")
                }
                
                Section {
                    Picker ("Measurement type", selection: $outputMeasurementType) {
                        ForEach(measurementTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                Section {
                    Text(convertedValue.formatted())
                } header: {
                    Text("Converted value")
                }
            }
            .navigationTitle("TimeConverter ⏳")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputValueIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
