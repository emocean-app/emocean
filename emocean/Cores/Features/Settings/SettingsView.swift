//
//  SettingsView.swift
//  emocean
//
//  Created by Farrel Anshary on 05/08/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var settingsVM: SettingsViewModel

    var body: some View {
        NavigationView {
            Form {
                Toggle("Music", isOn: $settingsVM.music)
                Toggle("Reduce motion", isOn: $settingsVM.reduceMotion)

                Section(footer: Text("Set the time and you will get notifications to remind you to reflect everyday")) {
                    Toggle(isOn: $settingsVM.reminder.animation(), label: {
                        VStack(alignment: .leading) {
                            Text("Set reminder")
                            if settingsVM.reminder {
                                Text(settingsVM.getTime())
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    })

                    if settingsVM.reminder {
                        DatePicker("", selection: $settingsVM.reminderTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(colorScheme == .light ? Color.theme.grayThird : Color.theme.grayPrimary)
            }))
            .navigationBarTitle(Text("Settings"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
