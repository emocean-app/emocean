//
//  CheckinView.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//
import SwiftUI

struct CheckinView: View {
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: PROPERTIES
    @StateObject var vm = CheckinViewModel()
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    let time = Time()
    
    var body: some View {
        ZStack {
            // background theme
            if vm.currentStep.viewType == .category || vm.currentStep.viewType == .feelings {
                Group {
                    VStack(spacing: 0) {
                        if vm.currentStep.viewType == .observation {
                            Image("Up\(time.getRawValue())")
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
            } else {
                Group {
                    LottieView(
                        filename: "\(time.getRawValue())Ending",
                        contentMode: .scaleAspectFit
                    )
                        .ignoresSafeArea()
                }
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: .move(edge: .top)
                    )
                )
            }
            
            
            // Views
            switch vm.currentStep.viewType {
            case .feelings:
                CheckinFeelingsView()
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .category:
                CheckinCategoryView()
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .description:
                CheckinDescriptionView(question: vm.currentStep.question.texts[0])
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
            case .succes:
                CheckinSuccessView()
            case .observation:
                CheckinObservationView(question: vm.currentStep.question.texts[0])
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .bottom)))
            case .prompt:
                CheckinPromptView()
            }
            
            // Button X
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .foregroundColor(.white)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .padding(.horizontal, 28)
                .padding(.top, 20)
                Spacer()
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
