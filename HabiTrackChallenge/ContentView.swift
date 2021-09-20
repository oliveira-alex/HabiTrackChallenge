//
//  ContentView.swift
//  HabiTrackChallenge
//
//  Created by Alex Oliveira on 20/09/21.
//

import SwiftUI

struct ContentView: View {
    @State private var newHabit = ""
    @State private var habits = ["Coding", "Running", "Lifting"]
    
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a new habit", text: $newHabit, onCommit: addNewHabit)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .horizontal])
                
                List(habits, id: \.self) {
                    Text($0)
                }
            }
            .navigationBarTitle("Habits")
            .alert(isPresented: $showingError) {
                Alert(title: Text("Already added"),
                      message: Text("Your list already has a habit with this same name"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewHabit() {
        if !habits.contains(newHabit) {
            habits.append(newHabit)
            
            newHabit = ""
        } else {
            showingError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
