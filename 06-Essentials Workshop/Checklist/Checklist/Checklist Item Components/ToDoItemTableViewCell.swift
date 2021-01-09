//
//  ToDoItemTableViewCell.swift
//  Checklist
//
//  Created by Stoyko Kolev on 19.09.20.
//

import UIKit

class ToDoItemTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "ToDoItemTableViewCell"
    
    @IBOutlet weak var checkMarkLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    
}
