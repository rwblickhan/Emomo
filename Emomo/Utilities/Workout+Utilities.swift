//
//  Workout+Utilities.swift
//  Emomo
//
//  Created by Russell Blickhan on 10/31/20.
//

import Foundation

extension Workout {
    var exerciseArray: [Exercise] {
        exercises?.sortedArray(using: []) as? [Exercise] ?? []
    }
}
