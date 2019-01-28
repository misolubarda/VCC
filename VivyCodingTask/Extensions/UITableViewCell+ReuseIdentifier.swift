//
//  UITableViewCell+ReuseIdentifier.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }

    static var nib: UINib? {
        guard let nibName = NSStringFromClass(self).split(separator: ".").last else { return nil }
        return UINib(nibName: String(nibName), bundle: nil)
    }
}
