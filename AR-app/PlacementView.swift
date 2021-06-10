//
//  PlacementView.swift
//  AR-app
//
//  Created by conganhhcmus on 10/06/2021.
//

import SwiftUI

struct PlacementView:View {
    @EnvironmentObject var placementSettings:PlacementSettings
    
    var body: some View{
        HStack{
            Spacer()
            PlacementButton(systemIconName: "xmark.circle.fill", action: {
                self.placementSettings.selectModel = nil
            })
            Spacer()
            PlacementButton(systemIconName: "checkmark.circle.fill", action: {
                self.placementSettings.confirmModel = self.placementSettings.selectModel
                self.placementSettings.selectModel = nil
            })
            Spacer()
        }
    }
}

struct PlacementButton:View {
    let systemIconName:String
    let action: ()-> Void
    
    var body: some View{
        Button(action:{
            self.action()
        }){
            Image(systemName: systemIconName)
                .font(.system(size:50,weight: .light,design: .default))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
            
        }
        .frame(width:75,height:75)
    }
}
