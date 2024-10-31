//
//  UIApplication+.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    static func showAlert(title: String?,
                          message: String? = nil,
                          preferredStyle: UIAlertController.Style = .alert,
                          actions: (() -> [UIAlertAction]) = { [.init(title: "OK", style: .default)] }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions() {
            alert.addAction(action)
        }
        
        UIApplication.shared.keyWindow?.rootViewController?.topMostPresentedController.present(alert, animated: true, completion: nil)
        return
    }
}
