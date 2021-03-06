//
//  NotificationHelper.swift
//  emocean
//
//  Created by Farrel Anshary on 13/08/21.
//

import Foundation
import SwiftUI

struct NotificationHelper {
    static func setupNotification(title: String, body: String, time: Date) {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { authorized, error in
            if authorized && error == nil {
                print("Authorized")
            } else if let error = error {
                print("\(error.localizedDescription)")
            } else {
                print("Not authorized")
            }
        }

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        let calendar = Calendar.current
        dateComponents.hour = calendar.component(.hour, from: time)
        dateComponents.minute = calendar.component(.minute, from: time)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "checkinNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        UserDefaults.standard.setValue(true, forKey: "reminder")
        UserDefaults.standard.setValue(time, forKey: "reminderTime")
        print("created")
    }

    func removeNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["checkinNotification"])
        print("removed")
    }
}
