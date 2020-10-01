//
//  WorkoutsView.swift
//  Emomo
//
//  Created by Russell Blickhan on 9/29/20.
//

import SwiftUI
import CoreData

struct WorkoutsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [], animation: .default)
    private var workouts: FetchedResults<Workout>
    
    var body: some View {
        NavigationView {
            workoutList
            .navigationBarTitle(NSLocalizedString("Workouts", comment: "Title of the workouts view"))
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private var workoutList: some View {
        List {
            ForEach(workouts) { workout in
                NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                    Text("\(workout.name ?? "")")
                }
            }
            .onDelete(perform: deleteItems)
            addWorkoutButton.padding()
        }
        .listStyle(InsetListStyle())
    }
    
    private var addWorkoutButton: some View {
        DisclosurelessNavigationLink(destination: AddWorkoutView()) {
            AddWorkoutCellView()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { workouts[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
