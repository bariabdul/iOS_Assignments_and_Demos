//
//  PolygonShape.swift
//  Polygons
//
//  Created by Kurt McMahon on 11/8/16.
//  Copyright (c) 2016 Northern Illinois University. All rights reserved.
//

import Foundation

class PolygonShape {
    
    // Properties
    var minimumNumberOfSides: Int = 3
    
    var maximumNumberOfSides: Int = 12
    
    var numberOfSides: Int
    
    var name: String {
        get {
            let polygonNames = ["Triangle", "Square", "Pentagon", "Hexagon",
                "Heptagon", "Octagon", "Nonagon", "Decagon", "Undecagon",
                "Dodecagon"]
            return polygonNames[numberOfSides - 3]
        }
    }
    
    // Methods
    
    init(minimumNumberOfSides: Int, maximumNumberOfSides: Int, numberOfSides: Int) {
        self.minimumNumberOfSides = minimumNumberOfSides
        self.maximumNumberOfSides = maximumNumberOfSides
        self.numberOfSides = numberOfSides
    }
    
    convenience init() {
        self.init(minimumNumberOfSides: 3, maximumNumberOfSides: 12, numberOfSides: 5)
    }
    
    func angleInDegrees() -> Double {
        return 180 * (Double(numberOfSides - 2) / Double(numberOfSides))
    }
    
    func angleInRadians() -> Double {
        return angleInDegrees() * (M_PI / 180)
    }

    func description() -> String {
        return "I am a \(self.numberOfSides)-sided polygon, (a.k.a. a \(name))"
            + " with interior angles of \(angleInDegrees()) degrees "
            + "(\(angleInRadians()) radians)"
    }
}
