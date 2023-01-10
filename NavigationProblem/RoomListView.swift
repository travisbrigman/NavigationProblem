//
//  RoomListView.swift
//  NavigationProblem
//
//  Created by Travis Brigman on 1/10/23.
//

import SwiftUI

struct Room: Hashable {
    let number: String
    let unit: String
    var isMapped: Bool
}

enum RoomFilter: String, CaseIterable {
    case all = "All"
    case mapped = "Mapped"
    case unmapped = "Unmapped"
}

var dummyData = [
Room(number: "3210", unit: "Tahoe West", isMapped: false),
Room(number: "3212", unit: "Tahoe West", isMapped: true),
Room(number: "3214", unit: "Tahoe West", isMapped: false),
Room(number: "3216", unit: "Tahoe West", isMapped: false),
Room(number: "3218", unit: "Tahoe West", isMapped: true),
Room(number: "1010", unit: "Bear Lake", isMapped: true),
Room(number: "1014", unit: "Bear Lake", isMapped: true),
Room(number: "1016", unit: "Bear Lake", isMapped: false),
Room(number: "1018", unit: "Bear Lake", isMapped: true),
Room(number: "1020", unit: "Bear Lake", isMapped: true),
Room(number: "1022", unit: "Bear Lake", isMapped: true),
Room(number: "1024", unit: "Bear Lake", isMapped: false),
Room(number: "1026", unit: "Bear Lake", isMapped: true),
Room(number: "1028", unit: "Bear Lake", isMapped: true),
Room(number: "1030", unit: "Bear Lake", isMapped: true),
Room(number: "1032", unit: "Bear Lake", isMapped: false),
Room(number: "1034", unit: "Bear Lake", isMapped: false)
]

struct RoomListView: View {
    @ObservedObject var model: Model
    
    let selectedUnitNames = ["Tahoe West", "Bear Lake"]
    
    @State private var selectedFilter = RoomFilter.all
    
    var body: some View {
        Form {
            Group {
                Spacer()
                Picker("foo", selection: $selectedFilter) {
                    ForEach(RoomFilter.allCases, id: \.self) { roomFilter in
                        Text(roomFilter.rawValue).tag(roomFilter)
                    }
                }
                .pickerStyle(.segmented)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            
            ForEach(model.selectedItems, id: \.self) { unitName in
                Section(unitName) {
                    ForEach(dummyData.filter { $0.unit == unitName }, id: \.number) { room in
                        switch selectedFilter {
                        case .all:
                            ListCell(room: room)
                        case .mapped:
                            if room.isMapped {
                                ListCell(room: room)
                            }
                        case .unmapped:
                            if !room.isMapped {
                                ListCell(room: room)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: ListCell
struct ListCell: View {
    var room: Room
    
    var body: some View {
        NavigationLink {Text(room.unit) } label: {
            HStack {
                Text(room.number)
                Spacer()
                cellIcon
            }
            .swipeActions {
                Button("Unmap") {
                    // TODO: Call Function that changes mapped state to false
                }
                .tint(.red)
            }
        }
    }
    
    private var exclamationIcon: some View {
        Image(systemName: "exclamationmark.circle.fill").foregroundColor(.red)
    }
    
    @ViewBuilder
    var cellIcon: some View {
        if room.isMapped {
            EmptyView()
        } else {
            exclamationIcon
        }
    }
}

struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView(model: Model())
    }
}
