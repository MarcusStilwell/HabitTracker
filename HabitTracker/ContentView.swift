//
//  ContentView.swift
//  HabitTracker
//
//  Created by Marcus Stilwell on 10/28/21.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    let actName: String
    var frequency: String
    var description: String
    var id = UUID()
    var completionCount: Int = 0
}

class Habits: ObservableObject {
    @Published var habitList = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(habitList) {
                UserDefaults.standard.set(encoded, forKey: "HabitList")
            }
        }
    }
    
    init() {
        if let habitList = UserDefaults.standard.data(forKey: "HabitList") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: habitList) {
                self.habitList = decoded
                return
            }
        }

        self.habitList = []
    }
}

struct ContentView: View {
    
    @State private var showingAddHabits = false
    @ObservedObject var habits = Habits()
    
    func removeHabit(at offsets: IndexSet) {
        habits.habitList.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(habits.habitList) { habit in
                    NavigationLink(destination: ActivityView(habits: habits, activityName: habit.actName, frequency: habit.frequency, description: habit.description)){
                        HStack{
                            VStack{
                                Text(habit.actName)
                                    .font(.headline)
                                
                                Text(habit.frequency)
                            }
                            Spacer()
                            
                            VStack {
                                Text("You have completed \(habit.actName)")
                                Text("\(habit.completionCount) times")
                            }
                        }
                    }
                }
                .onDelete(perform: removeHabit)
            }
            
            
            .navigationBarItems(trailing:
                Button(action: {
                    showingAddHabits.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
                .navigationBarTitle("Habit Tracker")
                .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showingAddHabits){
            AddHabitView(habits: self.habits)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
