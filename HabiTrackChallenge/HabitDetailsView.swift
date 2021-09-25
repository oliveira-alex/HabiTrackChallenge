//
//  HabitDetailsView.swift
//  HabiTrackChallenge
//
//  Created by Alex Oliveira on 25/09/21.
//

import SwiftUI

struct HabitDetailsView: View {
    @ObservedObject var habits: Habits
    let habit: Habit
    var habitIndex: Int {
        return habits.items.firstIndex(where: { $0.id == habit.id } )!
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Description")) {
                        Text(habit.description)
                    }
                    
                    Section(header: Text("Times Practiced")) {
                        Text(String(habit.timesPracticed))
                    }
                }
                
                HStack {
                    Button("−") { habits.items[habitIndex].timesPracticed -= 1 }
                        .font(.title)
                        .foregroundColor(.red)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                        )
                    
                    Text("    ")
                    
                    Button("+") { habits.items[habitIndex].timesPracticed += 1 }
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                        )
                }
                
                Spacer()
                    .layoutPriority(0)
            }
            .navigationBarTitle(habit.name)
        }
    }
    
    init(_ habits: Habits, _ habit: Habit) {
        self.habits = habits
        self.habit = habit
    }
}

struct HabitDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let previewHabit = Habit(
                name: "New Habit",
                description: "Habit description",
                timesPracticed: 199
        )
        HabitDetailsView(Habits(), previewHabit)
    }
}
