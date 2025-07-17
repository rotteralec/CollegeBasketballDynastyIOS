//
//  ContentView.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/14/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @Query private var schools: [school]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    @MainActor
    private func loadAndSyncSchoolsFromJson() async {
        print("Starting JSON data load and SwiftData sync")
        
        guard let url = Bundle.main.url(forResource: "schools", withExtension: "json") else {
            print("Failed to find Schools.json in app bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let schoolsFromJSON = try decoder.decode([school].self, from: data)
            
            for schoolJSON in schoolsFromJSON {
                //check if school in swift data from id
                let predicate = #Predicate<school> { $0.id == schoolJSON.id }
                var existingSchools: [school] = []
                
                do {
                    let descriptor = FetchDescriptor(predicate: predicate)
                    existingSchools = try modelContext.fetch(descriptor)
                } catch {
                    print("Error fetching existing teams: \(error)")
                }
                
                if let existingSchool = existingSchools.first {
                    //if School exists then
                    existingSchool.name = schoolJSON.name
                    existingSchool.mascot = schoolJSON.mascot
                    existingSchool.coach = schoolJSON.coach
                    existingSchool.city = schoolJSON.city
                    existingSchool.state = schoolJSON.state
                    
                    print("Updated existing school: \(existingSchool.name)")
                } else {
                    //School does not exist, insert into Swift Data\
                    //schoolJSON object created by the decoder already has default values for prestige and skills
                    modelContext.insert(schoolJSON)
                    print("Inserted new school from JSON: \(schoolJSON.name)")
                }
            }
            try modelContext.save() //saves all changes
            print("Finished JSON load and swift data sync.")
            
            
        } catch {
            print("Error loading or decoding products from JSON: \(error)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
