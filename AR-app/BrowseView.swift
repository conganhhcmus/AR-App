//
//  BrowseView.swift
//  AR-app
//
//  Created by conganhhcmus on 10/06/2021.
//

import SwiftUI

struct BrowseView: View {
    @Binding var showBrowse:Bool
    
    var body: some View{
        NavigationView {
            ScrollView(showsIndicators: false){
                ModelsByCategoryGrid(showBrowse: $showBrowse)
            }
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Button(action: {
                self.showBrowse.toggle()
            }){Text("Done").bold()})
        }
    }

}

struct ModelsByCategoryGrid:View {
    @Binding var showBrowse:Bool
    let models = Models()
    var body: some View{
        VStack{
            ForEach(ModelCategory.allCases, id: \.self){ category in
                if let ModelsByCategory = models.get(category: category){
                    HorizationGrid(showBrowse: $showBrowse, title: category.label, items: ModelsByCategory)
                }
                
            }
        }
    }
}

struct HorizationGrid:View {
    @EnvironmentObject var placementSettings:PlacementSettings
    @Binding var showBrowse:Bool
    let title:String
    var items:[Model]
    
    
    private let gridItems = [GridItem(.fixed(150))]
    var body: some View{
        VStack(alignment: .trailing){
            Separator()
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 22)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false){

                LazyHGrid(rows:gridItems, spacing:30){
                    ForEach(0..<items.count){ index in
                       let model = items[index]
                        ItemButton(model: model, action: {
                            // Todo
                            model.asyncLoadModelEntity()
                            self.placementSettings.selectModel = model
                            self.showBrowse = false
                        })
                    }
                }
                .padding(.horizontal,22)
                .padding(.vertical,10)
            }
        }
    }
}
struct ItemButton:View{
    let model:Model
    let action: ()->Void
    var body: some View{
        Button(action:{
            self.action()
        }){
            Image(uiImage: self.model.thumbnail)
                .resizable()
                .frame(height:150)
                .aspectRatio(1/1,contentMode: .fit)
                .background(Color(UIColor.secondarySystemFill))
                .cornerRadius(8.0)
        }
    }
}


struct Separator:View {
    var body: some View{
        Divider()
            .padding(.horizontal,20)
            .padding(.vertical,10)
    }
}
