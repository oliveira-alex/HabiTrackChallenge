//
//  ContentView.swift
//  HabiTrackChallenge
//
//  Created by Alex Oliveira on 20/09/21.
//

import SwiftUI

struct Habit: Identifiable {
    var name: String
    var description: String
    var timesPracticed: Int
    var id = UUID()
}

class Habits: ObservableObject {
    @Published var items: [Habit]
    
    init() {
        self.items = [
            Habit(name: "Coding", description: "Hacking with Swift", timesPracticed: 365),
            Habit(name: "Running", description: "Flying low", timesPracticed: 9),
            Habit(name: "Lifting", description: "Sweating my heart out", timesPracticed: 80)
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
    @ObservedObject var habits = Habits()

    @State private var showingAddHabitSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { habit in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                            HStack {
                                Text(String(habit.timesPracticed))
                                Text(habit.timesPracticed >= 2 ? "Times" : "Time")
                                    .font(.subheadline)
                            }
                        }
                        
                        Stepper("",
                                onIncrement: { habits.incrementTimesPracticedOf(habit) },
                                onDecrement: { habit.timesPracticed > 0 ? habits.decrementTimesPracticedOf(habit) : nil }
                        )
                    }
                }
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    self.showingAddHabitSheet.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingAddHabitSheet) {
//                    print("showing add sheet")
                AddHabitView(habits: self.habits)
            }
//            .alert(isPresented: $showingError) {
//                Alert(title: Text("Already added"),
//                      message: Text("Your list already has a habit with this same name"),
//                      dismissButton: .default(Text("OK")))
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.colorScheme, .dark)
    }
}
