//
//  WorkoutDetailView.swift
//  Emomo
//
//  Created by Russell Blickhan on 9/30/20.
//

import SwiftUI

struct WorkoutDetailView: View {
    var workoutID: ObjectIdentifier
    
    @FetchRequest(sortDescriptors: [])
    private var workouts: FetchedResults<Workout>
    
    private var workout: Workout? {
        workouts.first(where: { $0.id == workoutID })
    }

    var body: some View {
        Text(workout?.name ?? "")
        Text("Number of sets: \(workout?.numSets ?? 0)")
            .navigationBarTitle(workout?.name ?? "")
        List {
            ForEach(workout?.exercises?.sortedArray(using: []) as? [Exercise] ?? []) { exercise in
                Text("Exercise \(exercise.name ?? "")")
                Text("\(exercise.numReps) reps")
                Text("\(exercise.numSeconds) seconds")
            }
        }
        NavigationLink(
            NSLocalizedString("Edit", comment: "Title of the edit button in workout details"),
            destination: AddOrEditWorkoutView(state: .edit(workout)))
            .padding()
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWorkout = Workout()
        previewWorkout.name = "Workout"
        return WorkoutDetailView(workoutID: previewWorkout.id)
    }
}
