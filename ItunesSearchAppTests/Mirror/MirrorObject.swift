//
//  MirrorObject.swift
//  ItunesSearchAppTests
//
//  Created by Özgü Ataseven on 8.05.2022.
//

class MirrorObject {
    private let mirror: Mirror
    
    init(reflecting: Any) {
        mirror = Mirror(reflecting: reflecting)
    }
    
    func extract<T>(variableName: StaticString = #function) -> T? {
        extract(variableName: variableName, mirror: mirror)
    }
    
    private func extract<T>(variableName: StaticString, mirror: Mirror?) -> T? {
        guard let mirror = mirror else {
            return nil
        }

        guard let descendant = mirror.descendant("\(variableName)") as? T else {
            return extract(variableName: variableName, mirror: mirror.superclassMirror)
        }
        
        return descendant
    }
}

