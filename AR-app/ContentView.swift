//
//  ContentView.swift
//  AR-app
//
//  Created by conganhhcmus on 10/06/2021.
//

import SwiftUI
import RealityKit


struct ContentView: View {
    @EnvironmentObject var placementSettings:PlacementSettings
    @State private var isControlVisiable:Bool = true

    @State private var showBrowse:Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            ARViewContainer()
            if self.placementSettings.selectModel == nil {
                ControlView(isControlVisiable: $isControlVisiable, showBrowse: $showBrowse)
            } else {
                PlacementView()
            }
          
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable{
    @EnvironmentObject var placementSettings:PlacementSettings
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView(frame: .zero)
        
        self.placementSettings.sceneObserver = arView.scene.subscribe(to: SceneEvents.Update.self, {(event) in
            self.updateSceneView(for: arView)
        })
        
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {}
    
    private func updateSceneView(for arView: CustomARView){
        arView.focusEntity?.isEnabled = self.placementSettings.selectModel != nil
        if let confirmModel  = self.placementSettings.confirmModel, let modelEntity = confirmModel.modelEntity{
            
            self.place(modelEntity: modelEntity, in: arView)
            self.placementSettings.confirmModel = nil
        }
    }
    
    private func place(modelEntity: ModelEntity, in arView: ARView){
        let cloneEntity = modelEntity.clone(recursive: true)
        
        cloneEntity.generateCollisionShapes(recursive: true)
        
        arView.installGestures([.translation,.rotation,.scale], for: cloneEntity)
        
        let anchorEntity = AnchorEntity(plane: .any)
        anchorEntity.addChild(cloneEntity)
        arView.scene.addAnchor(anchorEntity)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(PlacementSettings())
            
    }
}
