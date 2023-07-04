//
//  WelcomePage.swift
//  OwnExpenses
//
//  Created by Egor Bubiryov on 07.02.2023.
//

import SwiftUI

struct WelcomePage: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var vm: TransactionViewModel
    @State private var amount: String = "0"
    @State private var deleteSwipe: CGSize = .zero
    @State private var sliderState: CGSize = .zero
    
    var body: some View {
        VStack {
            Spacer()
                        
            Title()
            
            TextWithSum(amount: $amount, deleteSwipe: $deleteSwipe)
            
            Divider().padding(.horizontal)
            
            NumPad(amount: $amount)
                        
            ZStack {
                SliderWay()
                
                TextInSlider()
                
                sliderCircle
            }
            .frame(width: 300, height: 80)
            .padding(.horizontal)
            .padding(.top)
                            
            Spacer()
        }
        .background(colorScheme == .dark ? .black : .white)
    }
    
    func saveSum() {
        guard let doubleAmount = Double(amount) else {
            vm.entrySum = 0
            return
        }
        vm.entrySum = doubleAmount
        amount = "0"
    }
    
    func swipe() -> CGFloat {
        guard sliderState.width > 0 else {
            return 0
        }
        guard sliderState.width < 215 else {
            return 215
        }
        return sliderState.width
    }
    
    var sliderCircle: some View {
        HStack {
            Circle()
                .fill(.primary)
                .overlay(
                    Image(systemName: "chevron.right.2")
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .bold()
                )
                .frame(width: 70)
                .padding(.leading, 7)
                .offset(x: swipe())
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            sliderState = value.translation
                        }
                        .onEnded { value in
                            if sliderState.width > 0 && sliderState.width < 215 {
                                withAnimation(.easeInOut(duration: 0.15)) {
                                    sliderState.width = 0
                                }
                            }
                            if sliderState.width >= 215 {
                                saveSum()
                                vm.indexColor = 0
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                                    vm.isNewUser = false
                                }
                                sliderState.width = 0
                            }
                        }
                )
            Spacer()
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
            .environmentObject(TransactionViewModel())
    }
}


struct Title: View {
    @State private var scale: CGFloat = 1
    var body: some View {
        Text("Enter your current balance")
            .font(.largeTitle)
            .bold()
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .padding(.bottom, 30)
            .scaleEffect(scale)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 1)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                return withAnimation(repeated) {
                    self.scale = 1.1
                }
            }
    }
}

struct TextInSlider: View {
    var body: some View {
        Text("Swipe to get started")
            .font(.callout)
            .bold()
            .offset(x: 30)
    }
}

struct SliderWay: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 60)
            .fill(.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 60)
                    .stroke(.primary, lineWidth: 3)
            )
    }
}
