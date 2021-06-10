//
//  ControlView.swift
//  AR-app
//
//  Created by conganhhcmus on 10/06/2021.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControlVisiable:Bool
    @Binding var showBrowse:Bool
    var body: some View{
        VStack{
            ControlVisibilityToggleButton(isControlVisiable: $isControlVisiable)
            
            Spacer()
            
            if(isControlVisiable){
                ControlButtonBar(showBrowse: $showBrowse)
            }
        }
    }
}

struct ControlVisibilityToggleButton: View {
    @Binding var isControlVisiable:Bool
    var body: some View{
        HStack{
            Spacer()
            ZStack{
                Color.black.opacity(0.25)
                Button(action: {
                    print("Control visibility btn clicked!")
                    self.isControlVisiable.toggle()
                }){Image(systemName: self.isControlVisiable ? "rectangle" : "slider.horizontal.below.rectangle")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
}

struct ControlButtonBar: View {
    @Binding var showBrowse:Bool
    
    var body: some View{
        HStack{
            ControlButton(systemIconName: "clock.fill",action: {
                print("Recent btn clicked!")
            })
            
            Spacer()
            
            ControlButton(systemIconName: "square.grid.2x2",action: {
                print("Browsw btn clicked!")
                self.showBrowse.toggle()
            }).sheet(isPresented: $showBrowse, content: {
                //Browse view
                BrowseView(showBrowse: $showBrowse)
            })
            
            Spacer()
            
            ControlButton(systemIconName: "slider.horizontal.3",action: {
                print("Settings btn clicked!")
            })
            
        }
        .frame(maxWidth:500)
        .padding(30)
        .background(Color.black.opacity(0.25))
        
    }
}

struct ControlButton:View{
    let systemIconName:String
    let action:() -> Void
    var body: some View{
        Button(action: {
            self.action()
        }){Image(systemName: systemIconName)
            .font(.system(size: 35))
            .foregroundColor(.white)
            .buttonStyle(PlainButtonStyle())
        }
        .frame(minWidth: 50, maxWidth: 50)
    }
}
