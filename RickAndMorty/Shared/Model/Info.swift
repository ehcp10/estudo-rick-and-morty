//
//  Info.swift
//  RickAndMorty
//
//  Created by Evandro de Paula on 24/05/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
