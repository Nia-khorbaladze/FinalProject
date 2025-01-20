//
//  BlurEffectService.swift
//  Cypher
//
//  Created by Nkhorbaladze on 20.01.25.
//

import UIKit

final class BlurEffectService {
    
    private var blurEffectView: UIVisualEffectView?

    func addBlurEffect(to view: UIView) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.blurEffectView = blurEffectView
    }
    
    func removeBlurEffect() {
        blurEffectView?.removeFromSuperview()
        blurEffectView = nil
    }
}
