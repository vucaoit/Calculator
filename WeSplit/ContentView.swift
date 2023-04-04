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
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.cyan, .purple]), startPoint: .leading, endPoint: .trailing)
                .blur(radius: 3)
                .ignoresSafeArea()
            VStack(alignment: .center){
                Form{
                    Section{
                        HStack{
                            Text("Amount : ")
                            Spacer()
                            TextField("Amount", value: $checkAmount,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                                .padding(.all,5)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white,lineWidth: 1))
                        }
                        HStack{
                            Text("Attender : ")
                            Picker("Number of People",selection: $numberOfPeople){
                                ForEach(2 ..< 100){
                                    Text("\($0) People").foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        Section{
                            Picker("Tip percentage",selection: $tipPercentage){
                                ForEach(tipPerscentages,id: \.self){
                                    Text($0,format: .percent)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                            }
                            .background(.ultraThinMaterial.opacity(0.6))
                            .cornerRadius(10)
                            .pickerStyle(.segmented)
                        } header: {
                            Text("How much tip do you want to leave?")
                        }
                        
                        Section {
                            HStack(){
                                Spacer()
                                Label("Total/Person : ", systemImage: "person.3.fill")
                                Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                Spacer()
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init())
                    .listRowBackground(Color.red.opacity(0))     // << here !!
                }
                .frame(width: 350,height: 300)
                .modifier(FormHiddenBackground())
            }
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .foregroundColor(.white)
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
