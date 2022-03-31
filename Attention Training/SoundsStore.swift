//
//  SoundsStore.swift
//  Attention Training
//
//  Created by Артур Погромский on 02.02.2022.
//


import Foundation
import AVFoundation

/// Object for storing sounds, view model for list of all sounds
class SoundsStore: ObservableObject {
	
}


/// Struct, that represents a set of distinct sounds(or only one sound) with optional dedicated AVAudioPlayer.
struct SoundWithPlayer: Identifiable, Hashable {
	let url: URL
	let names: [String]
	var player: AVAudioPlayer?
	var pan: Float = 0.0
	var volume: Float = 1.0
	var id = UUID()
}





extension SoundsStore {
	static let preinstalledSounds: [SoundWithPlayer] =
	[SoundWithPlayer(url: Bundle.main.url(forResource: "birds", withExtension: "mp3")!, names: ["birds"]),
	 SoundWithPlayer(url: Bundle.main.url(forResource: "water", withExtension: "mp3")!, names: ["water"]),
	 SoundWithPlayer(url: Bundle.main.url(forResource: "thunder_and_rain", withExtension: "mp3")!, names: ["thunder", "rain"]),
	 SoundWithPlayer(url: Bundle.main.url(forResource: "short", withExtension: "mp3")!, names: ["short"]),
	 SoundWithPlayer(url: Bundle.main.url(forResource: "heartbeat", withExtension: "mp3")!, names: ["heartbeat"]),
	 SoundWithPlayer(url: Bundle.main.url(forResource: "clock", withExtension: "mp3")!, names: ["short"]),
	 SoundWithPlayer(url: Bundle.main.url(forResource: "thunder_and_rain", withExtension: "mp3")!, names: ["thunder", "rain"]),
	 SoundWithPlayer(url: Bundle.main.url(forResource: "short", withExtension: "mp3")!, names: ["short"])]
		.compactMap { $0 }
}
