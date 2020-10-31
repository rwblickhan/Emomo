//
//  AddOrEditWorkoutView.swift
//  Emomo
//
//  Created by Russell Blickhan on 9/29/20.
//

import SwiftUI

enum AddOrEditWorkoutViewState {
    case add
    case edit(Workout?)
}

struct AddOrEditWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @State private var workoutName: String = ""
    @State private var numSets: Int32 = 1
    @State private var exercises = [AddExerciseData(name: "", numReps: 0, numSeconds: 0)]

    private var state: AddOrEditWorkoutViewState
    private var workout: Workout?

    init(state: AddOrEditWorkoutViewState) {
        self.state = state
        if case let .edit(workout) = state {
            self.workout = workout
            self._workoutName = .init(initialValue: workout?.name ?? "")
            self._numSets = .init(initialValue: workout?.numSets ?? 0)
            self
                ._exercises = .init(
                    initialValue: (workout?.exerciseArray ?? [])
                        .compactMap { AddExerciseData(exercise: $0) })
        }
    }

    var body: some View {
        VStack {
            titleTextField.padding()
            List {
                ForEach(exercises.indices, id: \.self) {
                    AddExerciseView(data: $exercises[$0])
                }
                // TODO: https://github.com/rwblickhan/Emomo/issues/1
                // This goes crashy crashy :(
//                .onDelete {
//                    exercises.remove(atOffsets: $0)
//                }
            }
            addExerciseButton.padding()
            numSetsStepper.padding()
            saveButton.padding()
        }
        .navigationBarTitle(title)
        .navigationBarItems(trailing: EditButton())
    }

    private var title: String {
        switch state {
        case .add: return NSLocalizedString("Add workout", comment: "Title of the add workout page")
        case .edit:
            return String.localizedStringWithFormat(
                NSLocalizedString("Edit %@", comment: "Title of the edit workout page. $1 is the name of the workout"),
                workoutName)
        }
    }

    private var titleTextField: some View {
        TextField(
            NSLocalizedString("Name your workout", comment: "Placeholder text for the workout name text field"),
            text: $workoutName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }

    private var addExerciseButton: some View {
        Button(NSLocalizedString("Add exercise", comment: "Label of button to add an exercise to a new workout")) {
            withAnimation {
                exercises.append(AddExerciseData(name: "", numReps: 0, numSeconds: 0))
            }
        }
    }

    private var numSetsStepper: some View {
        Stepper(
            String.localizedStringWithFormat(
                NSLocalizedString(
                    "Number of sets: %d",
                    comment: "Label of the stepper to set the number of sets in a workout. $1 is the number of sets"),
                numSets),
            value: $numSets,
            in: 1 ... Int32.max)
    }

    private var saveButton: some View {
        Button(NSLocalizedString("Save", comment: "Label of button to finish adding a workout")) {
            withAnimation {
                addWorkout()
                presentationMode.wrappedValue.dismiss()
            }
        }
        .disabled(workoutName.isEmpty || exercises.isEmpty)
    }

    private func addWorkout() {
        switch state {
        case .add:
            let newWorkout = Workout(context: viewContext)
            newWorkout.name = workoutName
            newWorkout.numSets = numSets
            newWorkout.exercises = NSSet(array: exercises.map { data in
                let exercise = Exercise(context: viewContext)
                exercise.name = data.name
                exercise.numReps = data.numReps
                exercise.numSeconds = data.numSeconds
                return exercise
            })
        case .edit:
            workout?.name = workoutName
            workout?.numSets = numSets
            workout?.exercises = NSSet(array: exercises.map { data in
                let exercise = Exercise(context: viewContext)
                exercise.name = data.name
                exercise.numReps = data.numReps
                exercise.numSeconds = data.numSeconds
                return exercise
            })
        }

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

struct AddOrEditWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrEditWorkoutView(state: .add)
    }
}
