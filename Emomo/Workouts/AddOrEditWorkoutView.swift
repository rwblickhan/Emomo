//
//  AddWorkoutView.swift
//  Emomo
//
//  Created by Russell Blickhan on 9/29/20.
//

import SwiftUI

struct AddWorkoutView: View {
    private struct Constants {
        static let navigationBarTitle = NSLocalizedString(
            "Add or edit workout",
            comment: "Title of the add-or-edit workout page")
        static let workoutNamePlaceholderText = NSLocalizedString(
            "Name your workout",
            comment: "Placeholder text for the workout name text field")
        static let finishButtonText = NSLocalizedString(
            "Finish!",
            comment: "Label of button to finish editing a workout")
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var workoutName: String = ""
    
    var body: some View {
        TextField(Constants.workoutNamePlaceholderText, text: $workoutName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        Button(Constants.finishButtonText) {
            withAnimation {
                let newWorkout = Workout(context: viewContext)
                newWorkout.name = workoutName

                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
        .navigationBarTitle(Constants.navigationBarTitle)
    }
}

struct AddOrEditWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
