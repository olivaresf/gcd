//
//  ViewController.swift
//  GCD
//
//  Created by Fernando Olivares on 3/25/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Timer that updates every 1/3 second repeating.
        let timer = Timer.scheduledTimer(timeInterval: 0.333,
                                         target: self,
                                         selector: #selector(updateLabel),
                                         userInfo: nil,
                                         repeats: true)
        timer.fire()
    }
    
    /// Checks if the label says "Hello", if so change it to "World".
    /// If the label doesn't say "Hello", change it to "Hello"
    @objc func updateLabel() {
        if label.text! == "Hello" {
            label.text = "World"
        } else {
            label.text = "Hello"
        }
    }
    
    @IBAction func loadAllEntries() {
        // Load entries from the database.
        //
        
        // Naive approach and optimize later.
        let database = Database()
        let begin = Date()
        for fileIndex in 0...9 {
            // fileIndex = 0
            database.load(fileID: fileIndex) { result in
                print("Loaded file \(fileIndex)")
                let end = Date()
                // print(end.timeIntervalSince(begin))
            }
        }
        
    }
    
}

