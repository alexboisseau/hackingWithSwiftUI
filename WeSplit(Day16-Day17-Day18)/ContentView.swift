//
//  ContentView.swift
//  WeSplit
//
//  Created by Alex Boisseau on 09/12/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.00
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    
    @FocusState private var amountIsFocused: Bool
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal / peopleCount
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header : {
                    Text("Amount")
                }
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave ?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header : {
                    Text("Total by person")
                }
                
                Section {
                    Text(grandTotal, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header : {
                    Text("Total amount (amount and tip)")
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                }

            }
                .navigationTitle("We Split 💰")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}
