//
//  SoundsListView.swift
//  Attention Training
//
//  Created by Артур Погромский on 08.02.2022.
//

import SwiftUI

struct SoundsListView: View {
	// Добавить позже, пока воспользоваться preinstalledSounds
	//@ObservedObject var soundsStore: SoundsStore
	@EnvironmentObject var player: Player
	@State private var selectedSoundsID = Set<UUID>()
	@State var editMode: EditMode = .active
	@Environment(\.presentationMode) var presentationMode
	var body: some View {
		VStack(alignment: .center) {
			List(SoundsStore.preinstalledSounds, selection: $selectedSoundsID) { sound in
				Text(sound.sounds.joined(separator: ", ").capitalized)
			}
			.environment(\.editMode, $editMode)
			Button {
				let selectedSounds = SoundsStore.preinstalledSounds.filter { selectedSoundsID.contains($0.id) }
				player.add(selectedSounds)
				presentationMode.wrappedValue.dismiss()
			} label: {
				Text("Add selected")
			}
		}
	}
}

struct SoundsListView_Previews: PreviewProvider {
	static var previews: some View {
		SoundsListView()
			.environmentObject(Player())
	}
}
