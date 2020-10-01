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
}

struct AddExerciseView: View {
    @Binding var data: AddExerciseData

    var body: some View {
        HStack {
            TextField(
                NSLocalizedString("push-ups", comment: "Placeholder text for the exercise name field"),
                text: $data.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        AddExerciseView(data: .constant(AddExerciseData(name: "Test Exercise", numReps: 10, numSeconds: 60)))
    }
}
