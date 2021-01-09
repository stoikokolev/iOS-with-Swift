//
//  DataModel.swift
//  Checklist
//
//  Created by Stoyko Kolev on 24.09.20.
//

import Foundation

class DataModel {
    var checklists: [Checklist] = []
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(
                forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue,
                                      forKey: "ChecklistIndex")
        }
    }
    
    class func nextChecklistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID + 1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    init() {
        loadChecklists()
        registerDefaults()
    }
    
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent(
            "Checklists.plist")
    }
    
    func saveChecklists() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(checklists)
            try data.write(to: dataFilePath(),
                           options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                checklists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }
    
    private func registerDefaults() {
        let dictionary = [ "ChecklistIndex": -1 ]
        UserDefaults.standard.register(defaults: dictionary)
    }
}
