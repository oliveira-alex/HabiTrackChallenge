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
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a new habit", text: $newHabit)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.top, .horizontal])
                
                List(habits, id: \.self) {
                    Text($0)
                }
            }
            .navigationBarTitle("Habits")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
