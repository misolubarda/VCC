//
//  AllCountriesInteractor.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

public class AllCountriesInteractor: AllCountriesUseCase {
    private let provider: CountriesProvider

    public init(provider: CountriesProvider) {
        self.provider = provider
    }

    public func fetch(_ completion: @escaping (Response<[Country]>) -> Void) {
        provider.fetch(completion)
    }
}
