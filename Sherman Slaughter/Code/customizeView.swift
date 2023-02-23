//
//  customizeView.swift
//  Sherman Slaughter
//
//  Created by Fabian Bautista on 2/17/23.
//

import SwiftUI

struct customizeView: View {
    @State var tempUsername:String = ""
    @State var tempColor:Color = Color(.sRGB, red: 1, green: 1, blue: 1)
    @State var tempAge = ""
    
    @EnvironmentObject var data:Data
    
    var body: some View {
        Form{
            TextField("Username:", text:$tempUsername)//Binding of state to user interface controls
            ColorPicker("Favorite Color", selection: $tempColor)
            TextField("Age:", text:$tempAge)
                .keyboardType(.decimalPad)
        }
        .onDisappear(){
            data.username = tempUsername
            data.favColor = tempColor
            data.age = tempAge
        }
    }
}

struct customizeView_Previews: PreviewProvider {
    static var previews: some View {
        customizeView(tempUsername: "", tempColor: Color(.sRGB, red: 1, green: 1, blue: 1), tempAge: "")
    }
}
