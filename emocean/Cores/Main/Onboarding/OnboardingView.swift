//
//  OnboardingView.swift
//  emocean
//
//  Created by Farrel Anshary on 18/08/21.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ScrollView {
            TabView {
                welcomeView()
                    .background(
                        Image("Background Onboarding")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )

                detailView(
                    image: "Check In",
                    title: "CHECK-IN",
                    desc: "Helping you find your pattern through daily and" +
                    "weekly check-in for you to understand yourself better",
                    hasButton: false
                )
                .padding(.bottom, 50)

                detailView(
                    image: "Reflect",
                    title: "REFLECT",
                    desc: "Several prompt questions are given to help you reflect and set goals for the future.",
                    hasButton: false
                )
                .padding(.bottom, 50)

                detailView(
                    image: "Track",
                    title: "TRACK",
                    desc: "Track and look back at your past reflections and see how you've grown.",
                    hasButton: true
                )
                .padding(.bottom, 50)
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(
                width: UIScreen.main.bounds.width ,
                height: UIScreen.main.bounds.height
            )
            .onAppear(perform: {
                setupAppearance()
            })
        }
        .edgesIgnoringSafeArea(.all)
    }

    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(
            Color.theme.primary
        )
        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(
            Color.theme.grayPrimary
        )
    }

    func welcomeView() -> some View {
        VStack {
            Text("Welcome to")
                .foregroundColor(.white)
            Image("Emocean writing")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 50)
            Text("An app for you to discover and manage your emotions")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
        }
        .position(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height * 0.725
        )
    }

    func detailView(image: String, title: String, desc: String, hasButton: Bool) -> some View {
        VStack {
            Spacer()
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .padding(.horizontal, 50)
                .padding(.bottom)
            Text(title)
                .font(.system(size: 28, weight: .heavy))
                .foregroundColor(Color.theme.primary)
                .padding(.bottom, 5)
            Text(desc)
                .foregroundColor(Color.theme.primary)
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)

            Spacer()

            PrimaryButton {
                Text("Let's Jump In!")
            } action: {
                UserDefaults.standard.setValue(true, forKey: "onboardingLaunched")
                presentationMode.wrappedValue.dismiss()
            }
            .opacity(hasButton ? 1 : 0)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
