//
//  ContentView.swift
//  HabiTrackChallenge
//
//  Created by Alex Oliveira on 20/09/21.
//

import SwiftUI

struct Habit: Identifiable {
    var name: String = "New Habit"
    var timesPracticed: Int = 1
    let id = UUID()
}

class Habits: ObservableObject {
    @Published var items: [Habit]
    
    init() {
        self.items = [
            Habit(name: "Coding", timesPracticed: 365),
            Habit(name: "Running", timesPracticed: 99),
            Habit(name: "Lifting", timesPracticed: 150)
        ]
    }
    
    func add(_ newHabit: Habit) {
        self.items.append(newHabit)
    }
    
    func delete(_ habit: Habit) {
        let habitIndex = self.items.firstIndex(where: { $0.id == habit.id })!
        self.items.remove(at: habitIndex)
    }
    
    func incrementTimesPracticedOf(_ habit: Habit) {
        let habitIndex = self.items.firstIndex(where: { $0.id == habit.id })!
        self.items[habitIndex].timesPracticed += 1
    }
    
    func decrementTimesPracticedOf(_ habit: Habit) {
        let habitIndex = self.items.firstIndex(where: { $0.id == habit.id })!
        self.items[habitIndex].timesPracticed -= 1
    }
}

struct ContentView: View {
    @State private var newHabitName = ""
    @ObservedObject var habits = Habits()

    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a new habit", text: $newHabitName, onCommit: addNewHabit)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .horizontal])
                
                List(habits.items) { habit in
                    Stepper(habit.name + "\n" + "Count: " + String(habit.timesPracticed),
                            onIncrement: { habits.incrementTimesPracticedOf(habit) },
                            onDecrement: { habits.decrementTimesPracticedOf(habit) }
                    )
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

        let newHabit = newHabitName != "" ? Habit(name: newHabitName, timesPracticed: 1) : Habit()
        habits.add(newHabit)

        newHabitName = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
