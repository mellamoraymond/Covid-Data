//
//  CovidData.swift
//  TableView
//
//  Created by Engr. John Raymond Ilagan on 9/12/20.
//  Copyright © 2020 John Raymond Ilagan. All rights reserved.
//

import Foundation

struct CovidData: Codable {
    let Countries: [Country]
}

struct Country: Codable {
    let Country: String
    let TotalConfirmed: Int
}
