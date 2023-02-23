//
//  inventoryView.swift
//  Sherman Slaughter
//
//  Created by Fabian Bautista on 2/17/23.
//

import SwiftUI

struct inventoryView: View {
    @EnvironmentObject var data:Data
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    Text("Welcome " + (data.username ?? "User")) //Reading of text from textfield
                    Text("Fish Caught")
                }
                    .padding(20)
                ScrollView(.horizontal,showsIndicators:false){
                    HStack{
                        ForEach(Array(data.fishCaughtColor.enumerated()), id: \.offset) { index, fish in //Creation of Views in a loop
                            VStack{
                                Image(fish + " fish")
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                switch (data.age){
                                    case "":
                                        Text("Set your age!")
                                    case "0":
                                        Text("Too young")
                                    case "99", "999":
                                        Text("Too old")
                                    default:
                                        Text(data.fishCaughtWeight[index] + " pounds") //Joining of strings
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(data.favColor)
    }
}

struct inventoryView_Previews: PreviewProvider {
    static var previews: some View {
        inventoryView()
    }
}
