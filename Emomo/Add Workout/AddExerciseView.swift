//
//  AddExerciseView.swift
//  Emomo
//
//  Created by Russell Blickhan on 9/30/20.
//

import SwiftUI

struct AddExerciseData {
    var name: String
    var numReps: Int32
    var numSeconds: Int32
    
    init(name: String, numReps: Int32, numSeconds: Int32) {
        self.name = name
        self.numReps = numReps
        self.numSeconds = numSeconds
    }
    
    init(exercise: Exercise) {
        self.init(
        name: exercise.name ?? "",
        numReps: exercise.numReps,
        numSeconds: exercise.numSeconds)
    }
}

struct AddExerciseView: View {
    @Binding var data: AddExerciseData

    var body: some View {
        VStack {
            HStack {
                numSecondsTextField.padding(.horizontal)
                Text(NSLocalizedString("seconds of", comment: "Interior label for add exercise view"))
                        .padding(.horizontal)
            }
            HStack {
                numRepsTextField.padding(.horizontal)
                nameTextField.padding(.horizontal)
            }
        }
    }
    
    private var numSecondsTextField: some View {
        TextField(
            "",
            value: $data.numSeconds,
            // TODO https://github.com/rwblickhan/Emomo/issues/7
            formatter: NumberFormatter())
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
    }
    
    private var numRepsTextField: some View {
        TextField(
            "",
            value: $data.numReps,
            // TODO https://github.com/rwblickhan/Emomo/issues/7
            formatter: NumberFormatter())
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
    }
    
    private var nameTextField: some View {
        TextField(
            NSLocalizedString("push-ups", comment: "Placeholder text for the exercise name field"),
            text: $data.name)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(data: .constant(AddExerciseData(name: "Test Exercise", numReps: 10, numSeconds: 60)))
    }
}
