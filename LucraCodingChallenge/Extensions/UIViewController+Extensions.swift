//
//  UIViewController+Extensions.swift
//  LucraCodingChallenge
//
//  Created by Christopher Guirguis on 10/31/24.
//

import UIKit

extension UIViewController {
    var topMostPresentedController: UIViewController {
      if let vc = self.presentedViewController {
        return vc.topMostPresentedController
      } else {
        return self
      }
    }
}
