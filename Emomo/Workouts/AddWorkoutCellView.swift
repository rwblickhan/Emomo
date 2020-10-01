//
//  AddWorkoutCellView.swift
//  Emomo
//
//  Created by Russell Blickhan on 9/29/20.
//

import SwiftUI

struct AddWorkoutCellView: View {
    var body: some View {
        HStack {
            Image(systemName: "plus")
            Text(NSLocalizedString("Add new workout", comment: "Title of a button to add a new workout"))
        }.foregroundColor(.blue)
    }
}
