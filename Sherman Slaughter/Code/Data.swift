//
//  Data.swift
//  Sherman Slaughter
//
//  Created by Fabian Bautista on 2/21/23.
//

import Foundation
import SwiftUI

class Data:ObservableObject
{
    @Published var username: String?
    @Published var favColor: Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @Published var age: String?
    @Published var fishCaught: [String] = ["green", "red", "blue", "green", "blue"]
}
