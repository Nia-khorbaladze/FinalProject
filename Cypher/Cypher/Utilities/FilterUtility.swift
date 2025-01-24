//
//  FilterUtility.swift
//  Cypher
//
//  Created by Nkhorbaladze on 21.01.25.
//

import Foundation

struct FilterUtility {
    static func filterItems<T: Identifiable>(
        _ items: [T],
        searchText: String,
        keyPaths: [KeyPath<T, String>]
    ) -> [T] {
        guard !searchText.isEmpty else { return items }
        let lowercasedSearchText = searchText.lowercased()
        return items.filter { item in
            keyPaths.contains { keyPath in
                item[keyPath: keyPath].lowercased().contains(lowercasedSearchText)
            }
        }
    }
}
