//
//  AllCountriesUseCase.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public protocol AllCountriesUseCase {
    func fetch(_ completion: @escaping (Response<[Country]>) -> Void)
}
