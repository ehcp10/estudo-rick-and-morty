//
//  Character.swift
//  RickAndMorty
//
//  Created by Evandro de Paula on 23/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation


struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let episode:[String]
    let url: String
    let created: String
    let image: String
    
    var imageUrl: NSURL? {
        return NSURL(string: image)
    }
}
