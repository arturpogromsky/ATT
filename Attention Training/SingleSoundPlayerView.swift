//
//  SingleSoundPlayerView.swift
//  Attention Training
//
//  Created by Артур Погромский on 09.02.2022.
//

import SwiftUI
import AVFAudio

/// Плеер, который может:
/// - Проигрывать/останавливать аудио
/// - Перематывать на  ±15 секунд
/// - Изменять громкость
/// - Изменять баланс громкости
/// [Опционально] добавить осцилограмму
struct SingleSoundPlayerView: View {
	// Воспроизводит ли сейчас плеер.
	@State private var isPlaying = false
	// Звук, переданный из view выше по иерархии.
	@Binding var sound: SoundBundle
	// Плеер для воспроизведения измененного звука
	var player: AVAudioPlayer?
	// Инициализатор принимает на входе Binding, которым инициализирует _sound, после чего создает и настраивает плеер
	init(for sound: Binding<SoundBundle>) {
		self._sound = sound
		self.player = try? AVAudioPlayer(contentsOf: self.sound.url)
		self.player?.pan = self.sound.pan
		self.player?.volume = self.sound.volume
	}
	
	var body: some View {
		VStack {
			// Плеер и кнопки прокрутки вперед/назад
			playbackControllers
			// Настройка баланса громкости
			audioBalanceSlider
			// Настройка звука
			volumeSlider
		}
		.padding()
	}
	
	var playbackControllers: some View {
		HStack {
			Spacer()
			// Кнопка прокрутки назад
			Button {
				// Для прокрутки на 15 секунд в AVAudioPlayer достаточно просто изменить currentTime на 15 секунд
				player?.currentTime -= 15
			} label: {
				Image(systemName: "gobackward.15")
					.resizable()
					.frame(width: Constants.forwardBackwardButtonSize,
								 height: Constants.forwardBackwardButtonSize)
			}
			
			Spacer()
			
			// Кнопка проигрывания
			Button {
				if isPlaying {
					player?.pause()
				} else if !isPlaying {
					player?.play()
				}
				isPlaying.toggle()
			} label: {
				Image(systemName: isPlaying ? "pause" : "play.fill")
					.resizable()
					.frame(width: Constants.playButtonSize,
								 height: Constants.playButtonSize)
			}
			
			Spacer()
			
			// Кнопка прокрутки вперед
			Button {
				// Для прокрутки на 15 секунд в AVAudioPlayer достаточно просто изменить currentTime на 15 секунд
				player?.currentTime += 15
			} label: {
				Image(systemName: "goforward.15")
					.resizable()
					.frame(width: Constants.forwardBackwardButtonSize,
								 height: Constants.forwardBackwardButtonSize)
			}
			Spacer()
		}
		.scaledToFit()
		.buttonStyle(.plain)
	}
	
	var audioBalanceSlider: some View {
		VStack(spacing: 0) {
			Text("Баланс громкости")
				.padding(.top)
			HStack {
				Text("L")
				Slider(value: $sound.pan, in: -1.0...1.0) { _ in
					// При изменении sound.pan изменить также player.pan
					if isPlaying {
						player?.pause()
						isPlaying = false
					}
					player?.pan = sound.pan
				}
				Text("R")
			}
			.padding(.horizontal)
		}
		.font(.title2)
	}
	
	var volumeSlider: some View {
		VStack(spacing: 0) {
			Text("Громкость(\(Int(sound.volume * 100))%)")
				.padding(.top)
			HStack {
				Slider(value: $sound.volume, in: 0.0...1.0) { _ in
					// При изменении sound.volume изменить также player.volume
					if isPlaying {
						player?.pause()
						isPlaying = false
					}
					player?.volume = sound.volume
				}
				.padding(.horizontal)
			}
		}
		.font(.title2)
	}
	struct Constants {
		static let playButtonSize: CGFloat = 100
		static let forwardBackwardButtonSize: CGFloat = 60
	}
}

struct SingleSoundPlayerView_Previews: PreviewProvider {
	static var previews: some View {
		SingleSoundPlayerView(for: .constant(SoundBundle(url: Bundle.main.url(forResource: "birds", withExtension: "mp3")!, sounds: ["birds"])))
	}
}
