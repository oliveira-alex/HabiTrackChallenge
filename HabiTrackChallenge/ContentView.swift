//
//  ContentView.swift
//  HabiTrackChallenge
//
//  Created by Alex Oliveira on 20/09/21.
//

import SwiftUI

struct Habit: Identifiable {
    let name: String
    var timesPracticed: Int
    let id = UUID()
}

struct ContentView: View {
    @State private var newHabitName = ""
    @State private var habits: [Habit] = [
        Habit(name: "Coding", timesPracticed: 365),
        Habit(name: "Running", timesPracticed: 99),
        Habit(name: "Lifting", timesPracticed: 150)]
    
    @State private var value = 0
    
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a new habit", text: $newHabitName, onCommit: addNewHabit)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .horizontal])
                
                List(habits) {
                    Text($0.name + "\n" + "Count: " + String($0.timesPracticed))
                    Stepper("", onIncrement: nil, onDecrement: nil)
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
//        if !habits.contains(newHabit) {
//            habits.append(newHabit)
//
//            newHabit = ""
//        } else {
//            showingError = true
//    }

        let newHabit = Habit(name: newHabitName, timesPracticed: 1)
        habits.append(newHabit)
    }
    
//    func incrementCountOf(_ habit: Habit) {
//        <#function body#>
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
