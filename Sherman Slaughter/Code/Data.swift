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
    @Published var favColor: Color = Color(.sRGB, red: 1, green: 1, blue: 1)
    @Published var age: String?
    @Published var fishCaughtColor: [String] = ["blue", "red"]
    @Published var fishCaughtWeight: [String] = ["12", "15"]//Storage of numbers

}
