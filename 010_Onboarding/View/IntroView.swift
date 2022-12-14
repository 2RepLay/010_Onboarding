//
//  IntroView.swift
//  010_Onboarding
//
//  Created by nikita on 17.10.2022.
//

import SwiftUI

struct IntroView: View {
	
	@State var showWalkThroughScreens: Bool = false
	@State var currentIndex: Int = 0
	
	var body: some View {
		ZStack {
			Color("BG")
				.ignoresSafeArea()
			
			IntroScreen()
				
			WalkThroughScreens()
			
			NavBar()
		}
		.animation(.interactiveSpring(response: 1.1, dampingFraction: 0.85, blendDuration: 0.85), value: showWalkThroughScreens)
		
	}
	
	@ViewBuilder 
	func NavBar() -> some View {
		let isLast = currentIndex == intros.count
		HStack {
			Button {
				if currentIndex > 0 {
					currentIndex -= 1
				} else {
					showWalkThroughScreens.toggle()	
				}
			} label: {
				Image(systemName: "chevron.left")
					.font(.title3)
					.fontWeight(.semibold)
					.foregroundColor(Color.black)
			}
			
			Spacer()
			
			Button("Skip") {
				currentIndex = intros.count
			}
			.font(.custom(sansRegular, size: 14))
			.foregroundColor(Color.black)
			.opacity(isLast ? 0 : 1)
			.animation(.easeInOut, value: isLast)
		}
		.padding(.horizontal, 15)
		.padding(.top, 10)
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.offset(y: showWalkThroughScreens ? 0 : -120)
	}
	
	@ViewBuilder
	func WalkThroughScreens() -> some View {
		let isLast = currentIndex == intros.count
		
		GeometryReader {
			let size = $0.size
			
			ZStack {
				ForEach(intros.indices, id: \.self) { index in
					ScreenView(size: size, index: index)
				}
				
				WelcomeView(size: size, index: intros.count)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.overlay(alignment: .bottom) { 
				ZStack {
					Image(systemName: "chevron.right")
						.font(.title3)
						.fontWeight(.semibold)
						.scaleEffect(!isLast ? 1 : 0.001)
						.opacity(!isLast ? 1 : 0)
					HStack {
						Text("Sign Up")
							.font(.custom(sansBold, size: 15))
							.foregroundColor(.white)
							.frame(maxWidth: .infinity, alignment: .leading)
						
						Image(systemName: "arrow.right")
							.font(.title3)
							.fontWeight(.semibold)
							.foregroundColor(.white)
					}
					.padding(.horizontal, 15)
					.scaleEffect(isLast ? 1 : 0.001)
					.frame(height: isLast ? nil : 0)
					.opacity(isLast ? 1 : 0)
				}
				.frame(width: isLast ? size.width / 1.5 : 55, height: isLast ? 50 : 55)
				.foregroundColor(.white)
				.background { 
					RoundedRectangle(cornerRadius: isLast ? 10 : 30, style: isLast ? .continuous : .circular)
						.fill()
				}
				.onTapGesture {
					currentIndex += 1
				}
				.offset(y: isLast ? -40 : -90)
				.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
			}
			.overlay(alignment: .bottom, content: { 
				let isLast = currentIndex == intros.count
				
				HStack(spacing: 5) { 
					Text("Already have an account?")
						.font(.custom(sansRegular, size: 14))
						.foregroundColor(.gray)
					
					Button("Login") {
						
					}
					.font(.custom(sansBold, size: 14))
					.foregroundColor(.black)
				}
				.offset(y: isLast ? -12 : 100)
				.animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5), value: isLast)
			})
			.offset(y: showWalkThroughScreens ? 0 : size.height)
		}	
	}
	
	@ViewBuilder
	func ScreenView(size: CGSize, index: Int) -> some View {
		let intro = intros[index]
		
		VStack(spacing: 10) { 
			Text(intro.title)
				.font(.custom(sansBold, size: 28))
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(
					.interactiveSpring(
						response: 0.9, 
						dampingFraction: 0.8, 
						blendDuration: 0.5
					)
					.delay(currentIndex == index ? 0.2 : 0)
					.delay(currentIndex == index ? 0.2 : 0),
					value: currentIndex
				)
			
			Text(dummyText)
				.font(.custom(sansRegular, size: 14))
				.multilineTextAlignment(.center)
				.padding(.horizontal, 30)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(
					.interactiveSpring(
						response: 0.9, 
						dampingFraction: 0.8, 
						blendDuration: 0.5
					)
					.delay(0.1)
					.delay(currentIndex == index ? 0.2 : 0), 
					value: currentIndex
				)
			
			Image(intro.imageName)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
				.frame(height: 250, alignment: .top)
				.padding(.horizontal, 20)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(
					.interactiveSpring(
						response: 0.9, 
						dampingFraction: 0.8, 
						blendDuration: 0.5
					)
					.delay(currentIndex == index ? 0 : 0.2)
					.delay(currentIndex == index ? 0.2 : 0),
					value: currentIndex
				)
		}
	}
	
	@ViewBuilder
	func WelcomeView(size: CGSize, index: Int) -> some View {
		
		VStack(spacing: 10) {
			Image("Welcome")
				.resizable()
				.aspectRatio(contentMode: .fit)
				.clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
				.frame(height: 250, alignment: .top)
				.padding(.horizontal, 20)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(
					.interactiveSpring(
						response: 0.9, 
						dampingFraction: 0.8, 
						blendDuration: 0.5
					)
					.delay(currentIndex == index ? 0 : 0.2)
					.delay(currentIndex == index ? 0.2 : 0),
					value: currentIndex
				)
			
			Text("Welcome")
				.font(.custom(sansBold, size: 28))
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(
					.interactiveSpring(
						response: 0.9, 
						dampingFraction: 0.8, 
						blendDuration: 0.5
					)
					.delay(currentIndex == index ? 0.2 : 0)
					.delay(currentIndex == index ? 0.2 : 0),
					value: currentIndex
				)
			
			Text(dummyText)
				.font(.custom(sansRegular, size: 14))
				.multilineTextAlignment(.center)
				.padding(.horizontal, 30)
				.offset(x: -size.width * CGFloat(currentIndex - index))
				.animation(
					.interactiveSpring(
						response: 0.9, 
						dampingFraction: 0.8, 
						blendDuration: 0.5
					)
					.delay(0.1)
					.delay(currentIndex == index ? 0.2 : 0), 
					value: currentIndex
				)
		}
	}
	
	
	@ViewBuilder
	func IntroScreen() -> some View {
		GeometryReader {
			let size = $0.size
			
			VStack(spacing: 10) { 
				Image("Intro")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: size.width, height: size.height / 2)
				
				Text("Clearhead")
					.font(.custom(sansBold, size: 27))
					.padding(.top, 55)
				
				Text(dummyText)
					.font(.custom(sansRegular, size: 14))
					.multilineTextAlignment(.center)
					.padding(.horizontal, 30)
				
				Text("Let's Begin")
					.font(.custom(sansSemiBold, size: 14))
					.padding(.horizontal, 40)
					.padding(.vertical, 14)
					.foregroundColor(.white)
					.background {
						Capsule()
							.fill()
					}
					.onTapGesture {
						showWalkThroughScreens.toggle()
					}
					.padding(.top, 30)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
			.offset(y: showWalkThroughScreens ? -size.height : 0)
		}
		.ignoresSafeArea()
	}
	
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
