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
	@State private var popupIsShowing = false
	@State private var soundToEdit: SoundWithPlayer?
	
	//MARK: - Body
	var body: some View {
		VStack {
			ZStack(alignment: .center) {
				background
				
				// Тулбар для кнопок(добавление новых звуков и т.д.)
				toolbar
				
				// Круглые цветные кнопки, отображающие текущие звуки. При нажатии позволяют изменить выбранный звук
				coloredCircleButtons
				
				// При нажатии на цветной круг свойству soundToEdit присваивается новое значение
				// После чего открывается редактор с плеером
				if let soundToEdit = soundToEdit {
					EditSoundView(for: soundToEdit)
						.zIndex(1) // Фикс бага, при котором не отрисовывался transition исчезновения
						.transition(AnyTransition.scale)
						.padding()
				}
			}
			
			// Начать тренировку
			startButton
		}
		.background(Color("background"))
		.sheet(isPresented: $soundsListIsShowing, onDismiss: nil) {
			SoundsListView()
		}
	}
	
	//MARK: -
	var background: some View {
		Color("background")
			.onTapGesture {
				withAnimation {
					soundToEdit = nil
				}
			}
	}
	
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
					RoundedRectangle(cornerRadius: Constants.cornerRadius)
						.strokeBorder(lineWidth: Constants.lineWidth)
						.foregroundColor(Color("border"))
				}
				.frame(height: 70)
				.padding(.horizontal, 49.0)
		}
		
	}
	
	var coloredCircleButtons: some View {
		ForEach(player.playlist) { soundBundle in
			ColoredCircleButton(soundBundle: soundBundle)
				.onTapGesture {
					withAnimation {
						soundToEdit = soundBundle
					}
				}
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
	@EnvironmentObject var player: Player
	var soundBundle: SoundWithPlayer
	
	/// Индекс звука в плейлисте
	var index: Int {
		player.playlist.index(matching: soundBundle)!
	}
	
	/// Угол, задающий положение круга
	var angle: Double {
		Double(index) * sector
	}
	
	/// Название звука, склеивается из названий звуков, соединенных символом новой строки
	var text: String {
		soundBundle.names
			.map { $0.capitalized }
			.joined(separator: "\n")
	}
	
	/// Угол между центрами двух кругов, в радианах
	var sector: Double {
		Double(2.0 * .pi / Double(player.playlist.count))
	}
	
	/// Диаметр круга
	var diameter: CGFloat {
		2.0 * CGFloat(Constants.offset.height * sin(sector / 2))
	}
	
	var body: some View {
		Circle()
			.frame(width: player.playlist.count == 1 ? Constants.offset.height * 2 : diameter,
						 height: player.playlist.count == 1 ? Constants.offset.height * 2 : diameter)
			.overlay {
				Text(text)
					.foregroundColor(.white)
					.font(.headline)
					.fontWeight(.bold)
					.multilineTextAlignment(.center)
					.scaledToFit()
					.rotationEffect(.radians(-angle))
			}
			.overlay {
				Circle()
					.strokeBorder(lineWidth: Constants.lineWidth)
					.foregroundColor(Color("border"))
			}
			.offset(player.playlist.count == 1 ? CGSize.zero : Constants.offset)
			.rotationEffect(.radians(angle))
			.foregroundColor(Constants.colors[index])
	}
}


fileprivate struct Constants {
	static let offset: CGSize = CGSize(width: 0, height: 110)
	static let count = 5
	static let lineWidth: CGFloat = 2
	static let cornerRadius: CGFloat = 15
	static let plusButtonScale: CGFloat = 0.7
	static let colors: [Color] = [.purple, .mint, .red, .yellow, .green, .orange, .cyan, .pink, .brown]
	static let basicFontSize: CGFloat = 55.0
}


struct SceneEditorView_Previews: PreviewProvider {
	static var previews: some View {
		PlayerMainView()
			.environmentObject(Player())
	}
}
