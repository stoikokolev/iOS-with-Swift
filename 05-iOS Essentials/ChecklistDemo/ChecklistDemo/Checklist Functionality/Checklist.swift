//
//  Checklist.swift
//  ChecklistDemo
//
//  Created by Stoyko Kolev on 28.12.20.
//

import Foundation

class Checklist {
    var name: String
    var checklistItems: [ChecklistItem] = []
    
    init(_ name: String) {
        self.name = name
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in checklistItems where !item.isChecked {
            count += 1
        }
        
        return count
    }
}
