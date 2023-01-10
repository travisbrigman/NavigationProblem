//
//  FirstView.swift
//  NavigationProblem
//
//  Created by Travis Brigman on 1/10/23.
//

import SwiftUI

struct FirstView: View {
    @EnvironmentObject private var model: Model
    
    var body: some View {
        NavigationStack(path: $model.navigationPaths) {
            NavigationLink(value: "Row 1") {
                Label("Row 1", systemImage: "1.circle")
            }
                .navigationDestination(for: [String].self) { _ in
                    RoomListView(model: Model())
                }
                .navigationDestination(for: String.self) { _ in
                    ContentView()
                }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
