//
//  Wrapper.swift
//  Sherman Slaughter
//
//  Created by Fabian Bautista on 2/21/23.
//

import SwiftUI

struct Wrapper: View {
    @StateObject var myData = Data()
    var body: some View {
        TabView {
            inventoryView().tabItem { Text("Inventory") }.tag(1)
            ContentView().tabItem { Text("Go Fishing") }.tag(2)
            customizeView().tabItem { Text("Settings") }.tag(3)
        }
        .environmentObject(myData)
        .accentColor(.gray)
    }
}

struct Wrapper_Previews: PreviewProvider {
    static var previews: some View {
        Wrapper()
    }
}

