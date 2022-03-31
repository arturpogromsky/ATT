//
//  SoundNamesScheduler.swift
//  Attention Training
//
//  Created by Артур Погромский on 21.02.2022.
//

import Foundation


class SoundNamesScheduler {
	let soundNames: [String]
	var currentSoundNameIndex = 0
	var timer: Timer?
	
	func scheduleNameToDisplay() {
		// Сначала 30 секунд
		timer = Timer.scheduledTimer(withTimeInterval: Constants.longFocusDuration, repeats: true) { _ in
			
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + Constants.longFocusStageDuration) { [weak self] in
			self?.timer?.invalidate()
		}
		// Потом 15 секунд
	}
	
	func setNextSoundNameIndex() {
		if currentSoundNameIndex < soundNames.count - 1 {
			currentSoundNameIndex += 1
		} else {
			currentSoundNameIndex = 0
		}
	}
	
	init(for soundNames: [String]) {
		self.soundNames = soundNames
	}
	
	struct Constants {
		static let longFocusDuration = 30.0
		static let longFocusStageDuration = 60.0 * 5
		static let shortFocusDuration = 15.0
		static let shortFocusStageDuration = 60.0 * 5
		static let dividedAttentionStageDuration = 60.0 * 2
	}
}
