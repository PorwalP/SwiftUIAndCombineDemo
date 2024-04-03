//
//  WordDetailsModel.swift
//  SwiftUICombineDemoProject
//
//  Created by Payal Porwal on 01/04/24.
//

import Foundation

struct WordDetailsModel : Codable {
    let word: String
    let sourceUrls: [String]
    let license: License
}

struct License: Codable {
    let name: String
    let url: String
}


