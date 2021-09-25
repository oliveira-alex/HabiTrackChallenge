//
//  AddHabitView.swift
//  HabiTrackChallenge
//
//  Created by Alex Oliveira on 24/09/21.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    
    @State private var newHabitName = ""
    @State private var newHabitDescription = ""
    
    @State private var showingError = false
    
//    func addNewHabit() {
////        if !habits.contains(newHabit) {
////            habits.append(newHabit)
////
////            newHabit = ""
////        } else {
////            showingError.toggle()
////    }
//
//        let newHabit = Habit(name: newHabitName, description: newHabitDescription, timesPracticed: 1)
//        habits.add(newHabit)
//
//        newHabitName = ""
//    }

    
    var body: some View {
        NavigationView {
            Form {
                TextField("New habit name", text: $newHabitName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("New habit description (optional)", text: $newHabitDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .navigationBarTitle("Add New Habit")
            .navigationBarItems(
                leading: Button("Cancel") { self.presentationMode.wrappedValue.dismiss() },
                trailing: Button("Save") {
                    if newHabitName == "" { newHabitName = "New Habit" }
                    
                    let newHabit = Habit(name: newHabitName, description: newHabitDescription, timesPracticed: 1)
                    self.habits.add(newHabit)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
             )
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        let habits = Habits()
        AddHabitView(habits: habits)
    }
}
