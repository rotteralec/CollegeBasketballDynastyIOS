//
//  TeamView.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/17/25.
//

import SwiftData
import SwiftUI

struct TeamView: View {

    // Helper to determine the color of a rating (0-100)
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

    var body: some View {
        ScrollView { // Allow scrolling if content overflows
            VStack(spacing: 20) { // Vertical stack with spacing between sections

                // MARK: Team Header
                VStack {
                    Text("Sample Team Name") // Hardcoded Team Name
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))

                    Text("Overall Rank: 3rd | Overall Rating: 90") // Hardcoded Rank and Overall
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 10)

                // MARK: Overall Rating Circle (Visual Emphasis)
                ZStack {
                    let overallRating = 90 // Hardcoded Overall Rating

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
                SectionHeader(title: "Offensive Efficiency")
                StatGrid(
                    stats: [
                        ("Offensive RTG", 92), // Points per 100 possessions
                        ("eFG%", 88),         // Effective Field Goal %
                        ("TS%", 89),          // True Shooting %
                        ("Assists/TO", 85)    // Assist to Turnover Ratio
                    ],
                    ratingColor: ratingColor
                )

                // MARK: Defensive Stats Section
                SectionHeader(title: "Defensive Efficiency")
                StatGrid(
                    stats: [
                        ("Defensive RTG", 88), // Points allowed per 100 possessions
                        ("Opponent eFG%", 80),// Opponent Effective Field Goal %
                        ("Block %", 75),      // Block percentage
                        ("Steal %", 80)       // Steal percentage
                    ],
                    ratingColor: ratingColor
                )

                // MARK: Rebounding & Pace
                SectionHeader(title: "Rebounding & Pace")
                StatGrid(
                    stats: [
                        ("Offensive REB %", 70), // Offensive Rebounding Percentage
                        ("Defensive REB %", 90), // Defensive Rebounding Percentage
                        ("Pace", 85)             // Pace Factor
                    ],
                    ratingColor: ratingColor
                )

                // MARK: Intangibles / General Strengths
                SectionHeader(title: "General Strengths")
                StatGrid(
                    stats: [
                        ("Chemistry", 95),       // Team chemistry
                        ("Coaching", 90),        // Coaching quality
                        ("Clutch Factor", 88)    // Performance in clutch moments
                    ],
                    ratingColor: ratingColor
                )
            }
            .padding() // Padding for the whole ScrollView content
        }
        .navigationTitle("Team Stats")
        .navigationBarTitleDisplayMode(.inline) // Keep title small
    }
}

// MARK: - Reusable Sub-Views (Same as PlayerStatRatingView)

// A clean header for each section
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

// A grid layout for displaying multiple stats in a compact way
private struct StatGrid: View {
    let stats: [(name: String, value: Int)]
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

// Individual stat item (e.g., "Offensive RTG: 92")
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

struct TeamStatRatingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Wrap in NavigationView for proper display of title
            TeamView()
        }
        .previewDisplayName("Team Stats (Light)")

        NavigationView {
            TeamView()
        }
        .preferredColorScheme(.dark)
        .previewDisplayName("Team Stats (Dark)")
    }
}
