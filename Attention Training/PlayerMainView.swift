//
//  SceneEditorView.swift
//  Attention Training
//
//  Created by Артур Погромский on 04.02.2022.
//

import SwiftUI


struct PlayerMainView: View {
	@EnvironmentObject var player: Player
	@State private var soundsListIsShowing = false
	
	/// Угол между центрами двух кругов, в радианах
	var sector: Double {
		Double(2.0 * .pi / Double(player.playlist.count))
	}
	
	/// Диаметр круга
	var diameter: CGFloat {
		2.0 * CGFloat(Constants.offset.height * sin(sector / 2))
	}
	
	//MARK: - Body
	var body: some View {
		VStack {
			ZStack(alignment: .center) {
				Color.black
				toolbar
				
				// Круглые цветные кнопки, отображающие текущие звуки. При нажатии позволяют изменить выбранный звук
				coloredCircleButtons
				
//				// Добавить новый звук в плейлист
//				newSoundButton
			}
			// Начать тренировку
			startButton
		}
		
		.background(Color.black)
		.sheet(isPresented: $soundsListIsShowing, onDismiss: nil) {
			SoundsListView()
		}
	}
	
	//MARK: -
	
//	@ViewBuilder
//	var newSoundButton: some View {
//		let offset = playerViewModel.player.playlist.isEmpty ? CGSize.zero : Constants.offset
//		Image(systemName: "plus.circle.fill")
//			.resizable()
//			.foregroundColor(.white)
//			.rotationEffect(.radians(sector))
//			.foregroundColor(.white)
//			.offset(offset)
//			.rotationEffect(.radians(-sector))
//			.frame(width: diameter * Constants.plusButtonScale,
//						 height: diameter * Constants.plusButtonScale)
//	}
	
	var startButton: some View {
		Button {
			player.play()
		} label: {
			RoundedRectangle(cornerRadius: Constants.cornerRadius)
				.foregroundColor(.accentColor)
				.overlay {
					Text("Start training")
						.font(.title)
						.foregroundColor(.white)
				}
				.overlay {
					// Заменить на buttonBorderShape
					RoundedRectangle(cornerRadius: Constants.cornerRadius)
						.strokeBorder(lineWidth: Constants.lineWidth)
						.foregroundColor(.white)
				}
				.frame(height: 70)
				.padding(.horizontal, 49.0)
		}
		
	}
	
	var coloredCircleButtons: some View {
		ForEach(player.playlist) { soundBundle in
			let index = player.playlist.index(matching: soundBundle)!
			let angle = Double(index) * sector
			let text = soundBundle.sounds
				.map { $0.capitalized }
				.joined(separator: "\n")
			ColoredCircleButton(angle: angle, text: text, diameter: diameter)
				.foregroundColor(Constants.colors[index])
		}
	}
	
	var toolbar: some View {
		VStack {
			HStack {
				Spacer()
				Button {
					// Открыть список всех звуков и добавить звуки в плейлист
					soundsListIsShowing = true
				} label: {
					Image(systemName: "plus")
						.font(.largeTitle)
						.padding()
				}
			}
			Spacer()
		}
	}
}


struct ColoredCircleButton: View {
	var angle: Double
	var text: String
	var diameter: CGFloat
	var body: some View {
		Circle()
			.frame(width: diameter, height: diameter)
			.overlay {
				Text(text)
					.foregroundColor(.white)
					.font(.headline)
					.fontWeight(.bold)
					.multilineTextAlignment(.center)
					.lineLimit(3)
					.rotationEffect(.radians(-angle))
			}
			.overlay {
				// Заменить на buttonBorderShape
				Circle()
					.strokeBorder(lineWidth: Constants.lineWidth)
					.foregroundColor(.white)
			}
			.offset(Constants.offset)
			.rotationEffect(.radians(angle))
	}
}


fileprivate struct Constants {
	static let offset: CGSize = CGSize(width: 0, height: 110)
	static let count = 5
	static let lineWidth: CGFloat = 2
	static let cornerRadius: CGFloat = 15
	static let plusButtonScale: CGFloat = 0.7
	static let colors: [Color] = [.purple, .mint, .red, .yellow, .green, .orange, .cyan, .pink, .brown]
}











struct SceneEditorView_Previews: PreviewProvider {
	static var previews: some View {
		PlayerMainView()
			.environmentObject(Player())
	}
}
