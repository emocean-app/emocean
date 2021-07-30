//
//  TestPicker.swift
//  emocean
//
//  Created by Christian Adiputra on 30/07/21.
//

import SwiftUI

struct TestPicker: View {
    @State var selection: String = "1"
    var body: some View {
        Picker(
            selection: .constant(1),
            label: Text("Picker"),
            content: {
            Text("1").tag(1)
            Text("2").tag(2)
        })
            .pickerStyle(MenuPickerStyle())
    }
}

struct TestPicker_Previews: PreviewProvider {
    static var previews: some View {
        TestPicker()
    }
}
