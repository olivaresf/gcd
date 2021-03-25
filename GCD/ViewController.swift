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
        
        let timer = Timer.scheduledTimer(timeInterval: 0.333,
                                         target: self,
                                         selector: #selector(updateLabel),
                                         userInfo: nil,
                                         repeats: true)
        timer.fire()
    }
    
    @objc func updateLabel() {
        if label.text! == "Hello" {
            label.text = "World"
        } else {
            label.text = "Hello"
        }
    }
    
    @IBAction func loadAllEntries() {
        let database = Database()
        let begin = Date()
        for index in 0...9 {
            let entry = try? database.load(fileID: index)
            print("Finished entry \(index)")
        }
        let end = Date()
        print(end.timeIntervalSince(begin))
    }
    
}

