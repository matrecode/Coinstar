//
//  GetCountriesUseCase.swift
//  Coinstar
//
//  Created by Akshay Matre on 05/10/26.
//

import Foundation

protocol GetCountriesUseCaseProtocol {
    func execute() -> [Country]
}

final class GetCountriesUseCase: GetCountriesUseCaseProtocol {
    private let repository: CountryRepositoryProtocol
    
    init(repository: CountryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> [Country] {
        repository.getAllCountries()
    }
}
