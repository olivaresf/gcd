//
//  Database.swift
//  GCD
//
//  Created by Fernando Olivares on 3/25/21.
//

import UIKit

class Database {
    
    func load(fileID: Int) throws -> [DatabaseEntry] {
        let filepath = Bundle.main.path(forResource: "JSON-\(fileID)", ofType: "txt")!
        let fileURL = URL(fileURLWithPath: filepath)
        let fileData = try Data(contentsOf: fileURL)
        let entries = try JSONDecoder().decode([DatabaseEntry].self, from: fileData)
        return entries
    }
    
}

struct DatabaseEntry : Codable {
    let nextEntry: Int
    let data: [DatabaseRow]
}

struct DatabaseRow : Codable {
    let id: String
    let about: String
}
