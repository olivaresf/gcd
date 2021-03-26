//
//  Database.swift
//  GCD
//
//  Created by Fernando Olivares on 3/25/21.
//

import UIKit

class Database {
    
    // Allows my app to become a parallel execution app.
    // concurrent means we can execute multiple blocks at the same time.
    // serial means one after the other
    private let databaseQueue = DispatchQueue(label: "DatabaseQ", attributes: .concurrent)
    
    /// Attempts to find a file named "JSON-(fileID).txt" and loads it into memory.
    /// - Parameter fileID: represents the file number
    /// - Throws: if it cannot find the file
    /// - Returns: a mock database table
    func load(fileID: Int, everythingIsDoneClosure: @escaping (Result<DatabaseTable, Error>) -> Void) {
    
        // for loop iteration
        // (main queue)
        // sync means we must _wait_ until the block is finished.
        // async means we do not wait.
        databaseQueue.async
        
        // 🟫 brown square
        // Will execute sometime in the future
        {
            do {
                let filepath = Bundle.main.path(forResource: "JSON-\(fileID)", ofType: "txt")!
                let fileURL = URL(fileURLWithPath: filepath)
                let fileData = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let entries = try decoder.decode(DatabaseTable.self, from: fileData)
                
                // Executing on the database queue
                DispatchQueue.main.sync
                {
                    // Executing on the main queu
                    everythingIsDoneClosure(.success(entries))
                    print("2")
                }
                
                print("1")
            } catch {
                DispatchQueue.main.async {
                    everythingIsDoneClosure(.success(entries))
                }
            }
        }
    } // Finishes execution
    // If the function finishes execution _before_ the closure gets called, we use escaping.
    // Do we reach line 40 before `everythingIsDoneClosure` gets called?
    // Yes, we do, so our closure is escaping and cannot be optimized.
    
    func loadWithoutEscaping(fileID: Int, everythingIsDoneClosure: (Result<DatabaseTable, Error>) -> Void) {
        
        // Main queue
        do {
            let filepath = Bundle.main.path(forResource: "JSON-\(fileID)", ofType: "txt")!
            let fileURL = URL(fileURLWithPath: filepath)
            let fileData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let entries = try decoder.decode(DatabaseTable.self, from: fileData)
            everythingIsDoneClosure(.success(entries))
        } catch {
            everythingIsDoneClosure(.failure(error))
        }
    }
    // Do we reach line 57 before we call `everythingIsDoneClosure`?
    // No, we do not.
}

struct DatabaseTable : Codable {
    let nextEntry: Int?
    let data: [DatabaseRow]
}

struct DatabaseRow : Codable {
    let id: String
    let about: String
}
