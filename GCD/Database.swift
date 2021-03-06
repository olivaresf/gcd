//
//  Database.swift
//  GCD
//
//  Created by Fernando Olivares on 3/25/21.
//

import UIKit

class Database {
    
    func load(fileID: Int) throws -> DatabaseTable {
        let filepath = Bundle.main.path(forResource: "JSON-\(fileID)", ofType: "txt")!
        let fileURL = URL(fileURLWithPath: filepath)
        let fileData = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let entries = try decoder.decode(DatabaseTable.self, from: fileData)
        return entries
    }
    
}

struct DatabaseTable : Codable {
    let nextEntry: Int?
    let data: [DatabaseRow]
}

struct DatabaseRow : Codable {
    let id: String
    let about: String
}
