//
//  SettingsViewModel.swift
//  emocean
//
//  Created by Farrel Anshary on 05/08/21.
//

import Foundation
import Combine
import UIKit

class SettingsViewModel: ObservableObject {
    @Published var music: Bool
    @Published var reduceMotion: Bool
    @Published var reminder: Bool
    @Published var reminderTime: Date

    var notification = NotificationHelper()

    var cancellable = Set<AnyCancellable>()

    init() {
        if let music = UserDefaults.standard.object(forKey: "music") as? Bool {
            self.music = music
        } else {
            self.music = true
        }

        if let reduceMotion = UserDefaults.standard.object(forKey: "reduceMotion") as? Bool {
            self.reduceMotion = reduceMotion
        } else {
            self.reduceMotion = false
        }

        if let date = UserDefaults.standard.object(forKey: "reminderTime") as? Date {
            self.reminderTime = date
        } else {
            self.reminderTime = Date()
        }

        if let reminder = UserDefaults.standard.object(forKey: "reminder") as? Bool {
            self.reminder = reminder
            reminder ? self.notif(self.reminderTime) : self.notification.removeNotification()
        } else {
            self.reminder = false
            self.notification.removeNotification()
        }

        setListeners()
    }

    func setListeners() {
        $music
            .sink { result in
                UserDefaults.standard.setValue(result, forKey: "music")
                if result {
                    SoundManager.shared.playSound(sound: .ocean)
                } else {
                    SoundManager.shared.stopSound(sound: .ocean)
                }
            }
            .store(in: &cancellable)

        $reduceMotion
            .sink { result in
                UserDefaults.standard.setValue(result, forKey: "reduceMotion")
            }
            .store(in: &cancellable)

        $reminder
            .sink { [weak self] result in
                UserDefaults.standard.setValue(result, forKey: "reminder")

                if !result {
                    self?.reminderTime = Date()
                    UserDefaults.standard.setValue(nil, forKey: "reminderTime")
                }

                result ? self?.notif(self!.reminderTime) : self?.notification.removeNotification()
            }
            .store(in: &cancellable)

        $reminderTime
            .sink { [weak self] result in
                UserDefaults.standard.setValue(result, forKey: "reminderTime")

                if let reminder = self?.reminder,
                   reminder {
                    self?.notif(result)
                } else {
                    self?.notification.removeNotification()
                }
            }
            .store(in: &cancellable)
    }

    func notif(_ time: Date) {
        NotificationHelper.setupNotification(
            title: "It is time to catch you emotion!",
            body: "How are you feeling now?",
            time: time
        )
    }

    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        return dateFormatter.string(from: reminderTime)
    }
}
