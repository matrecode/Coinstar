//
//  OnboardingService.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import Foundation
import Combine

class OnboardingService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService){
        self.networkService = networkService
    }
    
    func fetchOnboardingPages(fromLocalJson: Bool = false) -> AnyPublisher<[Onboarding], Error> {
        return fetchOnboardingPagesFromLocal(filename: "onboarding")
        
//        guard let url = URL(string: "http://127.0.0.1:3001/onboarding") else {
//            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
//        }
//        
//        return networkService.request(url)
//            .map { (response: OnboardingResponse) in
//                response.onboardingPages
//            }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
    }
    
    private func fetchOnboardingPagesFromLocal(filename: String) -> AnyPublisher<[Onboarding], Error> {
        Deferred {
            Future { promise in
                guard let url = Bundle.main.url(
                    forResource: filename,
                    withExtension: "json"
                ) else {
                    promise(.failure(URLError(.fileDoesNotExist)))
                    return
                }

                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(
                        OnboardingResponse.self,
                        from: data
                    )
                    promise(.success(response.onboardingPages))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

