//
//  ErrorAlertExtension.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorAlert(message: String = "Something went wrong. Try again later.") {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
