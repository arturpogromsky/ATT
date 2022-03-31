//
//  TrainingView.swift
//  Attention Training
//
//  Created by Артур Погромский on 04.02.2022.
//

import SwiftUI


struct TrainingView: View {
	@State private var currentSoundName = "Голубцов с говном"
	@EnvironmentObject var player: Player
	var timer: Timer?
	
	var soundNames: [String] {
		player.playlist.flatMap { $0.names }
	}
	
	var body: some View {
		ZStack {

			VStack(alignment: .center) {
				Text("Сосредоточься на звуке")
				Image(systemName: "star.fill")
				Text(currentSoundName)
					.foregroundColor(Constants.colors.randomElement())
			}
			.font(.largeTitle)
			.multilineTextAlignment(.center)
		}
	}
	

	
	struct Constants {
		static let colors: [Color] = [.purple, .mint, .red, .yellow, .green, .orange, .cyan, .pink, .brown]
		static let longFocusDuration = 30.0
		static let shortFocusDuration = 15.0
	}
}


struct TrainingView_Previews: PreviewProvider {
	static var previews: some View {
		TrainingView()
			.environmentObject(Player())
	}
}
