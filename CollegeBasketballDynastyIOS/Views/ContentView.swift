//
//  ContentView.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/14/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
          // Use NavigationStack for iOS 16+
          NavigationStack {
              VStack(spacing: 30) { // Vertical stack to arrange navigation buttons

                  Image(systemName: "basketball.fill")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 100, height: 100)
                      .foregroundColor(.orange)
                      .padding(.bottom, 20)

                  Text("Explore Statistics")
                      .font(.largeTitle)
                      .fontWeight(.bold)
                      .padding(.bottom, 30)

                  // MARK: Navigate to Player Stats
                  NavigationLink {
                      PlayerView() // Destination view for player stats
                  } label: {
                      Label("View Player Stats", systemImage: "person.fill")
                          .font(.title2)
                          .padding()
                          .frame(maxWidth: .infinity)
                          .background(Color.blue)
                          .foregroundColor(.white)
                          .cornerRadius(15)
                  }
                  .padding(.horizontal, 20)


                  // MARK: Navigate to Team Stats
                  NavigationLink {
                      TeamView() // Destination view for team stats
                  } label: {
                      Label("View Team Stats", systemImage: "person.3.fill")
                          .font(.title2)
                          .padding()
                          .frame(maxWidth: .infinity)
                          .background(Color.green)
                          .foregroundColor(.white)
                          .cornerRadius(15)
                  }
                  .padding(.horizontal, 20)
              }
              .navigationTitle("Stats Hub") // Title for this main navigation view
              .navigationBarTitleDisplayMode(.large) // Make the title larger
          }
      }
  }

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
