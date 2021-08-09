//
//  SettingsView.swift
//  emocean
//
//  Created by Farrel Anshary on 05/08/21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showModal: Bool
    @EnvironmentObject var vm: SettingsViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Music", isOn: $vm.music)
                Toggle("Reduce motion", isOn: $vm.reduceMotion)

                Section(footer: Text("Set the time and you will get notifications to remind you to reflect everyday")) {
                    Toggle(isOn: $vm.reminder.animation(), label: {
                        VStack(alignment: .leading) {
                            Text("Set reminder")
                            if vm.reminder {
                                Text(vm.getTime())
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    })

                    if vm.reminder {
                        DatePicker("", selection: $vm.reminderTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.showModal = false
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.theme.grayThird)
            }))
            .navigationBarTitle(Text("Settings"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showModal: .constant(true))
    }
}
