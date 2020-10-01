//
//  DisclosurelessNavigationLink.swift
//  Emomo
//
//  Created by Russell Blickhan on 9/29/20.
//

import SwiftUI

struct DisclosurelessNavigationLink<Content: View, Destination: View>: View {
    let destination: Destination
    let alignment: Alignment
    let content: () -> Content

    init(
        destination: Destination,
        alignment: Alignment = .center,
        @ViewBuilder content: @escaping () -> Content) {
        self.destination = destination
        self.alignment = alignment
        self.content = content
    }

    var body: some View {
        ZStack(alignment: alignment) {
            content()
            NavigationLink(destination: destination) {
                EmptyView()
            }
        }
    }
}
