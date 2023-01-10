//
//  Model.swift
//  NavigationProblem
//
//  Created by Travis Brigman on 1/10/23.
//

import Foundation
import SwiftUI

class Model: ObservableObject {
    @Published var navigationPaths = NavigationPath()
    @Published var selectedItems: [String] = []
}
