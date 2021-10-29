//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Marcus Stilwell on 10/28/21.
//

import SwiftUI

struct ActivityView: View {
    
    @ObservedObject var habits = Habits()
    @State private var actName: String = ""
    @State private var frequency: String = ""
    @State private var description: String = ""
    @State private var completionCount: Int = 0
    
    init(habits: Habits, activityName: String) {
        for activity in habits.habitList{
            if activity.actName == activityName {
                self.actName = activity.actName
                self.frequency = activity.frequency
                self.description = activity.description
                break
            }
        }
    }
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("\(description)")
                
                HStack{
                    Text("Complete \(frequency) task")
                    Button {
                        for acts in habits.habitList{
                            if acts.actName == self.actName{
                                completionCount += 1
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .navigationTitle("\(actName)")
        
        
        
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(habits: Habits(), activityName: "Hello")
    }
}
