//
//  InputView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 12.01.25.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    @State private var isSecureTextVisible: Bool = false
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    var inputFieldIcon: String? = nil
    var errorText: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            HStack {
                if let icon = inputFieldIcon {
                    Image(systemName: icon)
                        .foregroundStyle(Color(AppColors.lightGrey.rawValue))
                        .padding(.trailing, 8)
                }
                
                if isSecureField && !isSecureTextVisible {
                    SecureField(
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .foregroundColor(Color(AppColors.lightGrey.rawValue))
                    )
                        .font(Fonts.regular.size(15))
                        .foregroundColor(Color(AppColors.lightGrey.rawValue))
                } else {
                    TextField(
                        "",
                        text: $text,
                        prompt: Text(placeholder)
                            .foregroundColor(Color(AppColors.lightGrey.rawValue))
                    )
                        .font(Fonts.regular.size(15))
                        .foregroundColor(Color(AppColors.lightGrey.rawValue))
                }
                
                if isSecureField {
                    Button(action: {
                        isSecureTextVisible.toggle()
                    }) {
                        Image(systemName: isSecureTextVisible ? "eye.fill" : "eye.slash")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(errorText != nil ? Color.red : Color(AppColors.lightGrey.rawValue), lineWidth: 1)
            )
            
            HStack {
                Spacer()
                if let error = errorText {
                    Text(error)
                        .font(Fonts.regular.size(13))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                } else {
                    Text("")
                }
                Spacer()
            }
            .frame(height: 20)
            .padding(.top, 4)
        }
        .padding(.bottom, 8)
    }
}
