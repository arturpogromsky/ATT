////
////  ContentView.swift
////  Attention Training
////
////  Created by Артур Погромский on 24.01.2022.
////
//
//import SwiftUI
//
//struct ContentView: View {
//	@State var selectedSounds = Set<UUID>()
//	@ObservedObject var viewModel: PlayerViewModel
//	@ObservedObject var soundsStore: SoundsStore
//	@State private var editMode: EditMode = .active
//	var body: some View {
//		VStack {
//			PlayerView {
//				viewModel.add(selectedSounds)
//				viewModel.play()
//			}
//			NavigationView {
//				List(SoundsStore.preinstalledSounds, selection: $selectedSounds) { soundBundle in
//					Text(soundBundle.sounds.joined(separator: ", "))
//				}
//				.navigationTitle("Select songs")
//				.environment(\.editMode, $editMode)
//			}
//		}
//	}
//}
//
//
//struct PlayerView: View {
//	@State var isPlaying = false
//	var action: () -> Void
//	var body: some View {
//		Button {
//			action()
//		} label: {
//			Image(systemName: isPlaying ? "pause" : "play")
//				.resizable()
//				.scaledToFit()
//				.frame(width: 200, height: 200)
//		}
//	}
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//	static var previews: some View {
//		let viewModel = PlayerViewModel()
//		let soundsStore = SoundsStore()
//		ContentView(viewModel: viewModel, soundsStore: soundsStore)
//	}
//}
