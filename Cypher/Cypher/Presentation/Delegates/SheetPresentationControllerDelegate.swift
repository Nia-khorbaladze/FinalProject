//
//  SheetPresentationControllerDelegate.swift
//  Cypher
//
//  Created by Nkhorbaladze on 12.01.25.
//

import UIKit

extension AddWalletViewController: UISheetPresentationControllerDelegate {
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        removeBlurEffect()
    }
}
