//
//  AllCountriesInteractor.swift
//  DomainLayer
//
//  Created by Lubarda, Miso on 27.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import Foundation

class AllCountriesInteractor: AllCountriesUseCase {
    private let provider: CountriesProvider

    init(provider: CountriesProvider) {
        self.provider = provider
    }

    func fetch(_ completion: (Response<[Country]>) -> Void) {
        provider.fetch(completion)
    }
}
