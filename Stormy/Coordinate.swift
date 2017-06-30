//
//  Coordinate.swift
//  Stormy
//
//  Created by Izzy Ali on 30/06/2017.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible   {
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
