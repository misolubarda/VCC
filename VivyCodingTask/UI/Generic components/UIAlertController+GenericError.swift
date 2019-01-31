//
//  UIAlertController+GenericError.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 31.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func genericErrorAlert(_ completion: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: completion))
        return alert
    }
}
