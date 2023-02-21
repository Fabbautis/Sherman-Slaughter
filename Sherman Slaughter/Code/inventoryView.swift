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
                    Text("Welcome " + (data.username ?? "User"))
                    Text("Fish Caught")
                }
                    .padding(20)
                ScrollView(.horizontal,showsIndicators:false){
                    HStack{
                        ForEach(data.fishCaught, id: \.self) { fish in
                            VStack{
                                Image(fish + " fish")
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                Text(String(Int.random(in:5...40)) + " pounds")
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
