//
//  Response.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public enum Response<T> {
    case success(T)
    case error(Error)
}
