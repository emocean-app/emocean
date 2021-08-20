//
//  GoalTextView.swift
//  emocean
//
//  Created by Wilson Adrilia on 16/08/2021.
//

import SwiftUI

struct GoalTextView: View {
    var description = "test asasdas adsmdowamdoawm oawmda moamswdoamwmadowa mdawodmaow maowmdoa damdowmaodawmodmwa damwodmaowmd awwodmaowwdmawodmaw"
    var body: some View {
        VStack(alignment: .center){
            ScrollView{
                Text(description)
                    .padding(.init(top: 30, leading: 30, bottom: 20, trailing: 30))
                    .font(.body)
                    .frame(width: .infinity)
                    .multilineTextAlignment(.center)

            }
        }.frame(minHeight: 200, maxHeight: 250)
        .background(Color.white.opacity(0.75))
        .cornerRadius(30)
        
    }
}

struct GoalTextView_Previews: PreviewProvider {
    static var previews: some View {
        GoalTextView()
            .padding(.horizontal,16)
            .background(Color.orange
            )
    }
}
