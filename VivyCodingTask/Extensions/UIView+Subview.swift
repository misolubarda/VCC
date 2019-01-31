//
//  UIView+Subview.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 30.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit

extension UIView {
    func addSubview(_ subview: UIView, insets: UIEdgeInsets, relativeToSafeArea safeArea: Bool = false) {
        let leadingSuperAnchor = safeArea ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor
        let trailingSuperAnchor = safeArea ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor
        let topSuperAnchor = safeArea ? safeAreaLayoutGuide.topAnchor : topAnchor
        let bottomSuperAnchor = safeArea ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor

        let leadingSubAnchor = subview.leadingAnchor
        let trailingSubAnchor = subview.trailingAnchor
        let topSubAnchor = subview.topAnchor
        let bottomSubAnchor = subview.bottomAnchor

        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        leadingSubAnchor.constraint(equalTo: leadingSuperAnchor, constant: insets.left).isActive = true
        trailingSubAnchor.constraint(equalTo: trailingSuperAnchor, constant: -insets.right).isActive = true
        topSubAnchor.constraint(equalTo: topSuperAnchor, constant: insets.top).isActive = true
        bottomSubAnchor.constraint(equalTo: bottomSuperAnchor, constant: -insets.bottom).isActive = true
    }
}
