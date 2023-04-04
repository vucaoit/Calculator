//
//  ContentView.swift
//  Project 1
//
//  Created by vdcao on 4/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPerscentages = [10,15,20,25,0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section{
                        Label("Amount", systemImage: "dollarsign.circle")
                        TextField("Amount", value: $checkAmount,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of People",selection: $numberOfPeople){
                            ForEach(2 ..< 100){
                                Text("\($0) People")
                            }
                        }
                        Section{
                            Picker("Tip percentage",selection: $tipPercentage){
                                ForEach(tipPerscentages,id: \.self){
                                    Text($0,format: .percent)
                                }
                            }
                            .pickerStyle(.segmented)
                        } header: {
                            Text("How much tip do you want to leave?")
                        }
                        Section {
                            VStack(alignment: .leading){
                                HStack{
                                    Label("Amount :", systemImage: "dollarsign.circle")
                                    Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                }
                                HStack{
                                    Label("Total/Person : ", systemImage: "person.3.fill")
                                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}
