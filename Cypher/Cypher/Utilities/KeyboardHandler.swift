//
//  KeyboardHandler.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation
import UIKit

final class KeyboardHandler {
    private weak var view: UIView?
    private var bottomConstraint: NSLayoutConstraint?
    private let bottomOffset: CGFloat
    
    init(view: UIView, bottomConstraint: NSLayoutConstraint, bottomOffset: CGFloat = 20) {
        self.view = view
        self.bottomConstraint = bottomConstraint
        self.bottomOffset = bottomOffset
        setupKeyboardObservers()
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let view = view,
              let bottomConstraint = bottomConstraint else {
            return
        }
        
        let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
        let keyboardTop = keyboardFrameInView.minY
        let safeAreaBottom = view.safeAreaLayoutGuide.layoutFrame.maxY
        let offset = safeAreaBottom - keyboardTop
        
        bottomConstraint.constant = -(offset + bottomOffset)
        UIView.animate(withDuration: 0.3) {
            view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let view = view, let bottomConstraint = bottomConstraint else { return }
        
        bottomConstraint.constant = -bottomOffset
        UIView.animate(withDuration: 0.3) {
            view.layoutIfNeeded()
        }
    }
}
