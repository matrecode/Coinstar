//
//  LocalCountryRepositoryImpl.swift
//  Coinstar
//
//  Created by Akshay Matre on 05/10/26.
//

import Foundation

final class LocalCountryRepositoryImpl: CountryRepositoryProtocol {
    func getAllCountries() -> [Country] {
        Country.all
    }

    func getDefaultCountry() -> Country {
        Country.default
    }
}
