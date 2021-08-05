//
//  CheckinView.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import SwiftUI

struct CheckinView: View {
    
    // MARK: PROPERTIES
    @StateObject var vm = CheckinViewModel()
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        ZStack {
            // background theme
            Group {
                VStack(spacing: 0) {
                    if vm.screenState == .observation {
                        Image("UpNight")
                            .resizable()
                            .scaledToFit()
                            .transition(
                                .asymmetric(
                                    insertion: .move(edge: .top),
                                    removal: .move(edge: .top)
                                )
                            )
                    }
                    EMTheme.shared.sea
                }
                .ignoresSafeArea()
                backCoral
                frontCoral
            }
            
            // Views
            switch vm.currentStep.type {
            case .feelings:
                CheckinFeelingsView()
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .category:
                CheckinCategoryView()
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .description:
                CheckinDescriptionView(question: vm.currentStep.question)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
            case .succes:
                CheckinSuccessView()
            case .observation:
                CheckinObservationView(question: vm.currentStep.question)
            }
        }
        .environmentObject(vm)
    }
}

// MARK: - Components

extension CheckinView {
    
    var backCoral: some View {
        VStack(alignment: .trailing) {
            Spacer()
            Image("BackCoral")
                .resizable()
                .frame(
                    width: vm.getCoralWidth(),
                    height: 275,
                    alignment: .leading
                )
                
        }
        .frame(width: UIScreen.main.bounds.width, alignment: vm.getCoralAlignment())
        .ignoresSafeArea()
    }
    
    var frontCoral: some View {
        VStack(alignment: .trailing) {
            Spacer()
            Image("FrontCoral")
                .resizable()
                .frame(
                    width: vm.getCoralWidth(),
                    height: 300,
                    alignment: .leading
                )
        }
        .frame(width: UIScreen.main.bounds.width, alignment: vm.getCoralAlignment())
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct CheckinView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinView()
    }
}
