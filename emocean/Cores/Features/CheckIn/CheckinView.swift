//
//  CheckinView.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//
import SwiftUI

struct CheckinView: View {
    // MARK: ENVIRONMENT
    @Environment(\.presentationMode) var presentationMode
    // MARK: PROPERTIES
    // View Model
    @StateObject var viewModel = CheckinViewModel()
    // UI
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    @State private var sec = 0.0
    let time = Time()
    // MARK: BODY
    var body: some View {
        ZStack {
            // background theme
            if viewModel.currentStep.viewType == .category ||
                viewModel.currentStep.viewType == .feelings ||
                viewModel.currentStep.viewType == .observation {
                Group { // START: GROUP
                    VStack(spacing: 0) { // START: VSTACK
                        if viewModel.currentStep.viewType == .observation {
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
                    } // END: VSTACK
                    .ignoresSafeArea()
                    // Back Coral
                    backCoral
                    // Front Coral
                    frontCoral
                } // END: GROUP
                .transition(
                    .asymmetric(
                        insertion: .opacity,
                        removal: .move(edge: .bottom)
                    )
                )
            } else {
                Group { // START: GROUP
                    LottieView(
                        filename: "\(time.getRawValue())Ending",
                        contentMode: .scaleAspectFit
                    )
                        .ignoresSafeArea()
                } // START: GROUP
                .transition(
                    .asymmetric(
                        insertion: .move(edge: .top),
                        removal: .move(edge: .top)
                    )
                )
            }
            // Views
            viewsSelection
            // Button Close
            VStack { // START: VSTACK
                HStack { // START: HSTACK
                    Spacer()
                    if viewModel.currentStep.viewType != .succes {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(.white)
                            .onTapGesture {
                                presentationMode.wrappedValue.dismiss()
                            }
                            .zIndex(2)
                    }
                } // END: HSTACK
                .padding(.horizontal, 28)
                .padding(.top, 20)
                Spacer()
            } // END: VSTACK
        }
        .environmentObject(viewModel)
    }
}

// MARK: - Components
extension CheckinView {
    // Views Selection
    var viewsSelection: some View {
        Group {
            switch viewModel.currentStep.viewType {
            case .feelings:
                CheckinFeelingsView()
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .category:
                CheckinCategoryView()
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .description:
                CheckinDescriptionView()
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .opacity))
            case .succes:
                CheckinSuccessView()
            case .observation:
                VStack{ }
                    .onAppear(perform: {
                        viewModel.startTimer()
                    })
            }
        }
    }
    // Back Coral
    var backCoral: some View {
        VStack(alignment: .trailing) { // START: VSTACK
            Spacer()
            Image("BackCoral")
                .resizable()
                .frame(
                    width: viewModel.getCoralWidth(),
                    height: viewModel.getCoralHeight(isFront: false),
                    alignment: .leading
                )
        } // END: VSTACK
        .frame(width: UIScreen.main.bounds.width, alignment: viewModel.getCoralAlignment())
        .ignoresSafeArea()
    }
    // Front Coral
    var frontCoral: some View {
        VStack(alignment: .trailing) { // START: VSTACK
            Spacer()
            Image("FrontCoral")
                .resizable()
                .frame(
                    width: viewModel.getCoralWidth(),
                    height: viewModel.getCoralHeight(isFront: true),
                    alignment: .leading
                )
        } // END: VSTACK
        .frame(width: UIScreen.main.bounds.width, alignment: viewModel.getCoralAlignment())
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct CheckinView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinView()
    }
}
