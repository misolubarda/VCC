//
//  UIViewController+AddVC.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 30.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit

extension UIViewController {
    func embedChildVC(_ childVC: UIViewController, edgeInsets: UIEdgeInsets) {
        view.addSubview(childVC.view, insets: .zero)
        addChild(childVC)
        childVC.didMove(toParent: self)
    }
}
