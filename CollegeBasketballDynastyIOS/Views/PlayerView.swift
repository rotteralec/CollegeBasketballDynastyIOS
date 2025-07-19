//
//  PlayerView.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/17/25.
//

import SwiftData
import SwiftUI

struct PlayerView: View {
    @Query private var players: [player]
    // Helper to determine the color of a stat rating (0-100)
    private func ratingColor(_ rating: Int) -> Color {
        if rating >= 90 {
            return .green // Elite
        } else if rating >= 80 {
            return .teal // Excellent
        } else if rating >= 70 {
            return .blue // Very Good
        } else if rating >= 60 {
            return .orange // Good
        } else {
            return .red // Average or below
        }
    }
    let newPlayer = player(id: 0, fName: "AL", lName: "Rott", pos: "pg", year: 0, ht: 0, wt: 0, ln: 0, stats: PlayerSkills(), overall: 0, offense: 0, defense: 0)

    var body: some View {
        
        ScrollView { // Allow scrolling if content overflows
            VStack(spacing: 20) { // Vertical stack with spacing between sections

                // MARK: Player Header
                VStack {
                    Text("\(newPlayer.fName) \(newPlayer.lName)") // Hardcoded Player Name
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))

                    Text("Point Guard | Overall: 92") // Hardcoded Position and Overall
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 10)

                // MARK: Overall Rating Circle (Visual Emphasis)
                ZStack {
                    let overallRating = 92 // Hardcoded Overall Rating

                    Circle()
                        .stroke(lineWidth: 10)
                        .opacity(0.3)
                        .foregroundColor(ratingColor(overallRating))

                    Circle()
                        .trim(from: 0, to: CGFloat(overallRating) / 100.0)
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .foregroundColor(ratingColor(overallRating))
                        .rotationEffect(.degrees(-90)) // Start from top

                    Text("\(overallRating)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(ratingColor(overallRating))
                }
                .frame(width: 150, height: 150)
                .padding(.vertical, 20)


                // MARK: Offensive Stats Section
                SectionHeader(title: "Offense")
                StatGrid(
                    stats: [
                        ("Shooting", 95), // Hardcoded shooting
                        ("Ball Handling", 90), // Hardcoded ball handling
                        ("Passing", 88), // Hardcoded passing
                        ("Finishing", 85) // Hardcoded finishing
                    ],
                    ratingColor: ratingColor
                )

                // MARK: Defensive Stats Section
                SectionHeader(title: "Defense")
                StatGrid(
                    stats: [
                        ("Perimeter D", 82), // Hardcoded perimeter D
                        ("Interior D", 70),  // Hardcoded interior D
                        ("Steal", 75),       // Hardcoded steal
                        ("Block", 60),       // Hardcoded block
                        ("Rebounding", 65)   // Hardcoded rebounding
                    ],
                    ratingColor: ratingColor
                )

                // MARK: Physical Stats Section
                SectionHeader(title: "Physicals")
                StatGrid(
                    stats: [
                        ("Speed", 88),   // Hardcoded speed
                        ("Strength", 75), // Hardcoded strength
                        ("Stamina", 90)   // Hardcoded stamina
                    ],
                    ratingColor: ratingColor
                )
            }
            .padding() // Padding for the whole ScrollView content
        }
        .navigationTitle("Player Stats")
        .navigationBarTitleDisplayMode(.inline) // Keep title small
    }
}

// MARK: - Reusable Sub-Views (Extensions or Nested Structs)
// These sub-views still take parameters, but the data is passed from the hardcoded values above.

private struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(5)
    }
}

private struct StatGrid: View {
    let stats: [(name: String, value: Int)] // Still takes an array of tuples
    let ratingColor: (Int) -> Color

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 15)], spacing: 15) {
            ForEach(stats, id: \.name) { statName, statValue in
                StatItem(name: statName, value: statValue, ratingColor: ratingColor)
            }
        }
        .padding(.horizontal)
    }
}

private struct StatItem: View {
    let name: String
    let value: Int
    let ratingColor: (Int) -> Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.caption)
                .foregroundColor(.secondary)
            Text("\(value)")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(ratingColor(value))
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}

// MARK: - Previews

struct PlayerStatRatingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Wrap in NavigationView for proper display of title
            PlayerView()
        }
        .previewDisplayName("Light Mode")

        NavigationView {
            PlayerView()
        }
        .preferredColorScheme(.dark)
        .previewDisplayName("Dark Mode")
    }
}
