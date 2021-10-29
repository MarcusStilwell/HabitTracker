//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Marcus Stilwell on 10/28/21.
//

import SwiftUI

struct ActivityView: View {
    
    @ObservedObject var habits: Habits
    @State var actName: String
    @State private var frequency: String
    @State private var description: String
    
    init(habits: Habits, activityName: String, frequency: String, description: String) {
        self.habits = habits
        self.actName = activityName
        self.frequency = frequency
        self.description = description
    }
    
    
    var body: some View {
        NavigationView{
                VStack {
                    
                    Spacer()
                    Text("\(description)")
                    Spacer()

                    Button(action: {
                        if let activityIndex = habits.habitList.firstIndex(where: {$0.actName == self.actName}){
                            habits.habitList[activityIndex].completionCount += 1
                            }
                        }) {
                            Text("Complete \(frequency) task")
                        }
                    
                    Spacer()
                    
                    }
                .navigationBarTitle("\(self.actName)")
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(habits: Habits(), activityName: "Hello", frequency: "Weekly", description: "My description")
    }
}
