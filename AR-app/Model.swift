//
//  Model.swift
//  AR-app
//
//  Created by conganhhcmus on 10/06/2021.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory:CaseIterable {
    case table
    case chair
    case decor
    
    var label:String
    {
        get{
            switch self {
            case .table:
                return "Table"
            case .chair:
                return "Chair"
            case .decor:
                return "Decor"
                
            }
        }
    }
}

class Model {
    var name: String
    var category :ModelCategory
    var thumbnail: UIImage
    var modelEntity:ModelEntity?
    var scaleCompensation: Float
    
    private var cancelAble: AnyCancellable?
    
    init(name: String, category:ModelCategory, scaleCompensation:Float = 1.0){
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity(){
        let filename = self.name + ".usdz"
        self.cancelAble =  ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                switch loadCompletion{
                case .failure(let error): print("unable to load \(filename)")
                case .finished:
                    break
                }
            }, receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                print("had loaded")
                
            })
    }
    func setScale(scale:Float){
        self.scaleCompensation = scale
    }
}

struct Models {
    var all:[Model] = []
    init(){
        let chair_swan = Model(name:"chair_swan",category: .table,scaleCompensation: 5/100)
        let cup_saucer = Model(name:"cup_saucer_set",category: .table,scaleCompensation: 5/100)
        self.all += [chair_swan,cup_saucer,chair_swan,cup_saucer]
        
        let flower_tulip = Model(name:"flower_tulip",category: .chair,scaleCompensation: 5/100)
        let gramophone = Model(name:"gramophone",category: .chair,scaleCompensation: 5/100)
        self.all += [flower_tulip,gramophone,flower_tulip,gramophone]
        
        let teapot = Model(name:"teapot",category: .decor,scaleCompensation: 5/100)
        let wateringcan = Model(name:"wateringcan",category: .decor,scaleCompensation: 5/100)
        self.all += [teapot,wateringcan,teapot,wateringcan]
    }
    func get(category:ModelCategory) -> [Model] {
        all.filter({$0.category==category})
    }
}
