//
//  ContentView.swift
//  HabiTrackChallenge
//
//  Created by Alex Oliveira on 20/09/21.
//

import SwiftUI

struct Habit: Identifiable, Codable {
    var name: String
    var description: String
    var timesPracticed: Int
    var id = UUID()
}

class Habits: ObservableObject {
    @Published var items = [Habit]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
//        self.items = [
//            Habit(name: "Coding", description: "Hacking with Swift", timesPracticed: 365),
//            Habit(name: "Running", description: "Flying low", timesPracticed: 9),
//            Habit(name: "Lifting", description: "Sweating my heart out", timesPracticed: 80)
//        ]
        
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decodedItems = try? decoder.decode([Habit].self, from: items) {
                self.items = decodedItems
                return
            }
        }
        
        self.items = []
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
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
    
    func moveItem(from oldOffset: IndexSet, to newOffset: Int) {
        habits.items.move(fromOffsets: oldOffset, toOffset: newOffset)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { habit in
                    NavigationLink(destination: HabitDetailsView(habits, habit)) {
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
                .onDelete(perform: removeItems)
                .onMove(perform: { indices, newOffset in
                    moveItem(from: indices, to: newOffset)
                })
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
            .environment(\.colorScheme, .dark)
    }
}
