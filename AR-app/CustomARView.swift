//
//  CustomARView.swift
//  AR-app
//
//  Created by conganhhcmus on 10/06/2021.
//

import SwiftUI
import RealityKit
import FocusEntity
import ARKit

class CustomARView:ARView {
    var focusEntity: FocusEntity?
    
    required init(frame frameRect: CGRect){
        super.init(frame: frameRect)
        focusEntity = FocusEntity(on: self, style: .classic(color: UIColor.init()))
        configure()
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        session.run(config)
            
    }
}
