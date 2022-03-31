//
//  Player.swift
//  Attention Training
//
//  Created by Артур Погромский on 24.01.2022.
//

import Foundation
import AVFoundation


//MARK: - Model

/// Struct, that simultaniously plays multiple files from the `playlist`.
struct MultipleSoundsPlayer {
	/// Storage for sounds, that are scheduled to play.
	var playlist: [SoundWithPlayer] = [] // SoundsStore.preinstalledSounds
	
	/// Initialize AVAudioPlayer for each SoundsBundle, set it up and play. All sounds are looped and needs to be stopped somewhere else in the code.
	mutating func play() {
		for index in playlist.indices {
			playlist[index].player = try? AVAudioPlayer(contentsOf: playlist[index].url)
			playlist[index].player?.pan = playlist[index].pan
			playlist[index].player?.volume = playlist[index].volume
			playlist[index].player?.numberOfLoops = .max
			playlist[index].player?.play()
			// Escaping closure captures mutating `self` parameters
		}
	}
	
	/// Stop all currently playing sounds
	func stopAll() {
		for index in playlist.indices {
			playlist[index].player?.stop()
		}
	}
	
	/// Clear playlist
	mutating func clear() {
		playlist.removeAll() 
	}
	
	/// Add sounds to playlist
	mutating func add(_ sounds: [SoundWithPlayer]) {
		playlist.append(contentsOf: sounds)
	}
	
	/// Удалить `sounds` из плейлиста
	mutating func remove(_ sounds: [SoundWithPlayer]) {
		for sound in sounds {
			if let index = playlist.index(matching: sound) {
				playlist.remove(at: index)
			}
		}
	}
	
	mutating func updateSound(matching anotherSound: SoundWithPlayer) {
		if let index = playlist.index(matching: anotherSound) {
			playlist[index] = anotherSound
		}
	}
}


//MARK: - ViewModel
class Player: ObservableObject {
	@Published private(set) var player = MultipleSoundsPlayer()
	
	var playlist: [SoundWithPlayer] {
		player.playlist
	}
	
	var shutDownTimer: Timer?
	
	//MARK: - Intent functions
	
	/// Play all sounds in `playlist`, then, after duration seconds, stop and delete them from `playlist`
	func play(during time: Double = Constants.duration) {
		player.play()
		shutDownTimer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { [weak self] _ in
			self?.player.stopAll()
			self?.player.clear()
		}
	}
	
	/// Удалить из `names` звуки, которые уже есть в плейлисте. Добавить оставшиеся в плейлист.
	func add(_ sounds: [SoundWithPlayer]) {
		// let names = SoundsStore.preinstalledSounds.filter { names.contains($0.id) }
		let uniqueSounds = sounds.filter { !playlist.contains($0) }
		player.add(uniqueSounds)
	}
	
	/// Удалить `sounds` из плейлиста
	func remove(_ sounds: [SoundWithPlayer]) {
		player.remove(sounds)
	}
	
	func updateSound(matching anotherSound: SoundWithPlayer) {
		player.updateSound(matching: anotherSound)
	}
	
	struct Constants {
		// Duration in seconds
		static let duration: Double = 10
	}
}
