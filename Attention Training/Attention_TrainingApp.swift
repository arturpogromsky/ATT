//
//  Attention_TrainingApp.swift
//  Attention Training
//
//  Created by Артур Погромский on 24.01.2022.
//

import SwiftUI

@main
struct Attention_TrainingApp: App {
	@StateObject var playerViewModel = PlayerViewModel()
	@StateObject var soundsStore = SoundsStore()
	var body: some Scene {
		WindowGroup {
			PlayerMainView()
				.environmentObject(playerViewModel)
		}
	}
}
