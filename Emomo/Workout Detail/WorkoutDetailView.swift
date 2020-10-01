//
//  WorkoutDetailView.swift
//  Emomo
//
//  Created by Russell Blickhan on 9/30/20.
//

import SwiftUI

struct WorkoutDetailView: View {
    private let workout: Workout

    init(workout: Workout) {
        self.workout = workout
    }

    var body: some View {
        Text(workout.name ?? "")
        Text("Number of sets: \(workout.numSets)")
            .navigationBarTitle(workout.name ?? "")
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let previewWorkout = Workout()
        previewWorkout.name = "Workout"
        return WorkoutDetailView(workout: previewWorkout)
    }
}
