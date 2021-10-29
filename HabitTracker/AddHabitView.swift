//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Marcus Stilwell on 10/28/21.
//

import SwiftUI

struct AddHabitView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    @State private var actName: String = ""
    @State private var frequency: String = ""
    
    static let frequencies = ["Daily", "Weekly", "Monthly"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $actName)
                Picker("Type", selection: $frequency) {
                    ForEach(Self.frequencies, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                    let habit = Activity(actName: self.actName, frequency: self.frequency)
                    self.habits.habitList.append(habit)
                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
