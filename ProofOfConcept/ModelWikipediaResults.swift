//
//  ModelWikipediaResults.swift
//  ProofOfConcept
//
//  Created by Philipp Maier on 2/23/22.
//

import Foundation

struct wikipediaResult: Codable {
    let batchcomplete: String
    let query: Query
}

struct Query: Codable {
    let geosearch: [ Geosearch ]
}

struct Geosearch: Codable, Identifiable {
    
    var id: Int { pageid }
    let pageid: Int
    let title: String
    let lat: Double
    let lon: Double
    let dist: Double
    // let primary: String?
}

