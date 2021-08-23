//
//  WeeklyForm.swift
//  emocean
//
//  Created by Puras Handharmahua on 22/08/21.
//

import SwiftUI

struct WeeklyForm: View {
    // MARK: ENVIRONMENT
    @EnvironmentObject var env: WeeklyViewModel
    // MARK: PROPERTIES
    @State private var text: String = ""
    @State private var showTextField: Bool = false
    @State private var sec = 0.0
    @State var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    let time = Time()
    private let model: SecondaryWeeklyCheckinStep
    // MARK: INIT
    init(model: WeeklyCheckinStep) {
        guard let model = model as? SecondaryWeeklyCheckinStep else {
            self.model = SecondaryWeeklyCheckinStep(id: 0, next: 0, question: "")
            return
        }
        self.model = model
    }
    // MARK: BODY
    var body: some View {
        ZStack { // START: ZTACK
            VStack(alignment: .center) { // START: VSTACK
                Spacer(minLength: 35)
                Text(model.question)
                    .frame(maxWidth: .infinity, minHeight: 110, alignment: .bottom)
                    .padding()
                    .font(.title)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(
                        time.timeRange == .night ? .white : Color.theme.primary
                    )
                    .transition(.move(edge: .top))
                // Show TextField or not
                if showTextField {
                    MultilineTextField(text: $text, onCommit: {
                        env.goToNextStep(id: model.next)
                    })
                    .padding(.horizontal)
                }
                Spacer()
            } // END: VSTACK
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        } // END: ZTACK
        .onReceive(timer, perform: { _ in
            if sec == Double(2.0) {
                withAnimation(.easeInOut) {
                    showTextField = true
                }
                timer.upstream.connect().cancel()
                sec = 0.0
            } else {
                sec += 0.5
            }
        })
        .preferredColorScheme(
            time.timeRange == .night ? .dark : .light
        )
    }
}

struct WeeklyForm_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WeeklyViewModel()
        WeeklyForm(model: viewModel.currentStep)
            .environmentObject(viewModel)
    }
}
