//
//  PlacementSettings.swift
//  AR-app
//
//  Created by conganhhcmus on 10/06/2021.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings :ObservableObject {
    @Published var selectModel : Model? {
        willSet(newValue){
            print("Setting select")
        }
    }
    
    @Published var confirmModel: Model? {
        willSet(newValue){
            guard let model = newValue else {
                print("clear confirm")
                return
            }
            print("confirm select")
        }
    }
    
    var sceneObserver: Cancellable?
}

