//
//  Spinner.swift
//  Wezzr
//
//  Created by Dauren Omarov on 07.11.2021.
//

import UIKit

var someView: UIView?

extension UIViewController {
    
    func showSpinner() {
        someView = UIView(frame: self.view.bounds)
        if let someSafeView = someView {
            someSafeView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = someSafeView.center
            activityIndicator.startAnimating()
            someView?.addSubview(activityIndicator)
            self.view.addSubview(someSafeView)
        }
    }
    
    func removeSpinner() {
        someView?.removeFromSuperview()
        someView = nil
    }
    
    func displayError() {
        if let someSafeView = someView {
            someSafeView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.9)
        
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = someSafeView.center
            activityIndicator.startAnimating()
            someView?.addSubview(activityIndicator)
            self.view.addSubview(someSafeView)
        }
    }
}
