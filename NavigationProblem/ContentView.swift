//
//  ContentView.swift
//  NavigationProblem
//
//  Created by Travis Brigman on 1/10/23.
//

import SwiftUI

struct FakeFacility: Identifiable, Hashable {
    let id: Int
    let name: String
}

private var developmentDataFacilityUnits = [
    FakeFacility(id: 1, name: "Tahoe West"),
    FakeFacility(id: 2, name: "Bear Lake"),
    FakeFacility(id: 3, name: "Maroon Bells")
]

struct ContentView: View {
    @StateObject private var model = Model()

    @State private var showingAlert = false

    
    var body: some View {
        Form {
            Section {
                List(developmentDataFacilityUnits, id: \.id) { unit in
                    UnitListCell(unit: unit, multiSelection: $model.selectedItems)
                }
            } header: {
                Text("Units")
            }
            Button("View Rooms") {
                if model.selectedItems.isEmpty {
                    showingAlert.toggle()
                } else {
                    model.navigationPaths.append(model.selectedItems)
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .alert("No Units Selected", isPresented: $showingAlert) {
                Button("OK") { }
            }
        }
    }
}


struct UnitListCell: View {
    var unit: FakeFacility
    @Binding public var multiSelection: [String]
    var body: some View {
        HStack {
            Text(unit.name)
            Spacer()
            cellIcon
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if multiSelection.contains(unit.name) {
                self.multiSelection.removeLast()
            } else {
                self.multiSelection.append(unit.name)
            }
        }
    }
    
    @ViewBuilder
    var cellIcon: some View {
        if multiSelection.contains(unit.name) {
            Image(systemName: "checkmark.circle.fill").foregroundColor(Color.blue)
        } else {
            Image(systemName: "circle").foregroundColor(Color.blue)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
