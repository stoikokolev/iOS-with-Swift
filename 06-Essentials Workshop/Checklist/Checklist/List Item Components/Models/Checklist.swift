//
//  Checklist.swift
//  Checklist
//
//  Created by Stoyko Kolev on 23.09.20.
//

import Foundation

class Checklist: Codable {
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

extension Checklist: Equatable {
    static func == (lhs: Checklist, rhs: Checklist) -> Bool {
        lhs.name == rhs.name && lhs.checklistItems == rhs.checklistItems
    }
}
