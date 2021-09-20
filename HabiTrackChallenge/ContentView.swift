//
//  ContentView.swift
//  HabiTrackChallenge
//
//  Created by Alex Oliveira on 20/09/21.
//

import SwiftUI

struct ContentView: View {
    var habits = ["Coding", "Running", "Lifting"]
    
    var body: some View {
        NavigationView {
            VStack {
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
