//
//  AddHabitView.swift
//  HabiTrackChallenge
//
//  Created by Alex Oliveira on 24/09/21.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var habits: Habits
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        let habits = Habits()
        AddHabitView(habits: habits)
    }
}
