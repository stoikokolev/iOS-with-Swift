//
//  ViewController.swift
//  ChecklistDemoProject
//
//  Created by Stoyko Kolev on 29.12.20.
//

import UIKit

class CheckViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension CheckViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "checkTableViewCell", for: indexPath)
        
            return cell
    }
}

extension CheckViewController: UITableViewDelegate {
    //highlight when tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //check/uncheck when tap
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
        
    }
}

