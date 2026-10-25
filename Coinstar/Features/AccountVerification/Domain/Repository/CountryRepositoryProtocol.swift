//
//  CountryRepositoryProtocol.swift
//  Coinstar
//
//  Created by Akshay Matre on 05/10/26.
//

import Foundation

protocol CountryRepositoryProtocol {
    func getAllCountries() -> [Country]
    func getDefaultCountry() -> Country
}
