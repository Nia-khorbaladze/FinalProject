//
//  SearchBar.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField(
                "",
                text: $searchText,
                prompt: Text("Search...")
                    .foregroundColor(Color(AppColors.lightGrey.rawValue))
            )
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(AppColors.greyBlue.rawValue))
                .cornerRadius(30)
                .foregroundColor(Color(AppColors.lightGrey.rawValue))
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(AppColors.lightGrey.rawValue))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color(AppColors.lightGrey.rawValue))
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    isEditing = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                }
                .transition(.move(edge: .trailing))
                .animation(.default, value: isEditing)
            }
        }
        .padding(.horizontal)
    }
}
