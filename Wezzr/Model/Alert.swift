//
//  Alert.swift
//  Wezzr
//
//  Created by Dauren Omarov on 08.11.2021.
//

import Foundation
import UIKit

struct Alert {
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
}
