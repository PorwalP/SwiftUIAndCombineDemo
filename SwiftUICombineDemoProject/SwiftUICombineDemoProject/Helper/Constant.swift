//
//  Constant.swift
//  SwiftUICombineDemoProject
//
//  Created by Payal Porwal on 03/04/24.
//

import Foundation

struct ConstantsString {
    static let navigationTitle = "Words info"
    static let serverBaseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    static let defaultSelectedWord = "Hello"
//    let
}

enum ErrorStrings: String {
    case failedToDecode = "Failed to decode response"
    case invalidStatusCode = "Request falls within the range"
}

enum DetailedViewScreenString: String {
    case word = "Word:"
    case sourceUrl = "sourceUrl:"
    case licenseName = "license name:"
    case licenseURL = "license URL:"
}


final class Constant {
    static let words: [String] = ["Hello","Payals","Welcome"]
}




