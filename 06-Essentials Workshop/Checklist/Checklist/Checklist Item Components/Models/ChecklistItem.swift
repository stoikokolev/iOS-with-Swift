//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Stoyko Kolev on 20.09.20.
//

import Foundation
import UserNotifications

class ChecklistItem: Codable {
    var itemName: String
    var isChecked: Bool
    var dueDate: Date
    var shouldRemind: Bool
    var itemID = -1
    
    init(_ itemName: String, isChecked: Bool, shouldRemind: Bool, dueDate: Date) {
        self.itemName = itemName
        self.isChecked = isChecked
        self.shouldRemind = shouldRemind
        self.dueDate = dueDate
        itemID = DataModel.nextChecklistItemID()
    }
    
    deinit {
        removeNotification()
    }
    
    func modifyIsChecked() {
        isChecked.toggle()
    }
    
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = itemName
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(
                identifier: "\(itemID)", content: content,
                trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            print("Scheduled: \(request) for itemID: \(itemID)")
        }
    }
    
    private func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(
            withIdentifiers: ["\(itemID)"])
    }
}

extension ChecklistItem: Equatable {
    static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
        lhs.isChecked == rhs.isChecked && lhs.itemName == rhs.itemName
    }
}
