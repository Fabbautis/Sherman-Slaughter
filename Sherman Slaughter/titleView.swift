//#imageLiteral(resourceName: "7CAA7F74-E614-4F9F-ADBA-F4E6417F7F1B_1_201_a.jpeg")
//  titleView.swift
//  Sherman Slaughter
//
//  Created by Fabian Bautista on 2/17/23.
//

import SwiftUI

struct titleView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Hello name!")
                Image("wet")
                NavigationLink(destination:ContentView()) {
                    Text("Start game")
                }
                HStack{
                    NavigationLink(destination:inventoryView()) {
                        Text("View Fish")
                    }
                    NavigationLink(destination:customizeView()) {
                        Text("Customize")
                    }
                }
            }
        }
    }
}

struct titleView_Previews: PreviewProvider {
    static var previews: some View {
        titleView()
    }
}
