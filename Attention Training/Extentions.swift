//
//  Extentions.swift
//  Attention Training
//
//  Created by Артур Погромский on 08.02.2022.
//

import SwiftUI

// Добавить оператор умножения CGSize на CGFloat
extension CGSize {
	static func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
		CGSize(width: lhs.width * rhs,
					 height: lhs.height * rhs)
	}
}

// Найти элемент в коллекции с Identifiable-элементами
extension Collection where Element: Identifiable, Index == Int {
	func index(matching element: Element) -> Index? {
		self.firstIndex(where: { $0.id == element.id })
	}
}
