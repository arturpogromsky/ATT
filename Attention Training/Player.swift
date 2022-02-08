//
//  Player.swift
//  Attention Training
//
//  Created by Артур Погромский on 24.01.2022.
//

import Foundation
import AVFoundation

//MARK: Model

/// Struct, that simultaniously plays multiple files from the `playlist`.
struct Player {
	/// Storage for sounds, that are scheduled to play.
	var playlist: [SoundBundle] = [] // SoundsStore.preinstalledSounds
	
	/// Initialize AVAudioPlayer for each SoundsBundle, set it up and play. All sounds are looped and needs to be stopped somewhere else in the code.
	mutating func play() {
		for index in playlist.indices {
			playlist[index].player = try? AVAudioPlayer(contentsOf: playlist[index].url)
			playlist[index].player?.pan = playlist[index].pan
			playlist[index].player?.volume = playlist[index].volume
			playlist[index].player?.numberOfLoops = .max
			playlist[index].player?.play()
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
	mutating func add(_ sounds: [SoundBundle]) {
		playlist.append(contentsOf: sounds)
	}
}



//MARK: ViewModel
class PlayerViewModel: ObservableObject {
	@Published private(set) var player = Player()
	
	var playlist: [SoundBundle] {
		player.playlist
	}
	
	var shutDownTimer: Timer?
	
	//MARK: Intent functions
	/// Play all sounds in `playlist`, then, after duration seconds, stop and delete them from `playlist`
	func play(during time: Double = Constants.duration) {
		player.play()
		shutDownTimer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { [weak self] _ in
			self?.player.stopAll()
			self?.player.clear()
		}
	}
	
	/// Добавить в плейлист те звуки, которых там еще нет
	func add(_ sounds: [SoundBundle]) {
		// let sounds = SoundsStore.preinstalledSounds.filter { sounds.contains($0.id) }
		let uniqueSounds = sounds.filter { !playlist.contains($0) }
		player.add(uniqueSounds)
	}
	
	struct Constants {
		// Duration in seconds
		static let duration: Double = 10
	}
}
