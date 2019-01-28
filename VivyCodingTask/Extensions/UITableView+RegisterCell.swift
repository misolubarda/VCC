//
//  UITableView+RegisterCell.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T>(for cellClass: T.Type) where T: UITableViewCell {
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
