//
//  WeeklyCheckin.swift
//  emocean
//
//  Created by Wilson Adrilia on 19/08/2021.
//

import SwiftUI

struct WeeklyCheckin: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    .frame(width: geometry.size.width / 4)
                    Image("Bubble")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 4)
                }
                Spacer()
            }
        }
    }
}

struct WeeklyCheckin_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyCheckin().background(EMTheme.shared.sea.ignoresSafeArea())
    }
}
