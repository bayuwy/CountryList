//
//  CountriesViewModel.swift
//  CobaLogin
//
//  Created by developer on 27/01/23.
//

import Foundation
import RxSwift
import RxRelay

class CountriesViewModel {
    let countryList: BehaviorRelay<[Countries]> = BehaviorRelay<[Countries]>(value: [])
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
//    var countries: [Countries] = []
    
    func fetchCountries(completion: @escaping (Error?) -> Void) {
        isLoading.accept(true)
        CountriesAPI.shared.fetchCountries { [weak self] (result) in
            switch result {
            case .success(let countries):
                self?.isLoading.accept(false)
                self?.countryList.accept(countries)
                completion(nil)
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
//    func fetch(completion: @escaping () -> ()) {
//        CountriesAPI.shared.fetchData { countries in
//            self.countries = countries
//            dump(self.countries)
//            self.countries.sort(by: {$0.name?.common ?? "" < $1.name?.common ?? ""})
//            completion()
//        }
//    }
    
    func numberOrRows() -> Int {
        return self.countryList.value.count
    }
    
    func countryName(at index: Int) -> String? {
        return self.countryList.value[index].name?.common
    }
    
    func countryFlag(at index: Int) -> String? {
        return self.countryList.value[index].flags.png!
    }
    
//    func countryCapital(at index: Int) -> String? {
//        return self.countries[index].capital?.last ?? ""
//    }
//    
//    func countryLanguage(at index: Int) -> Any {
//        return self.countries[index].languages ?? [:]
//    }
//    
//    func countryRegion(at index: Int) -> String? {
//        return self.countries[index].region 
//    }
//    
//    func countrySubRegion(at index: Int) -> String? {
//        return self.countries[index].subregion 
//    }
//    
//    func countryPopulation(at index: Int) -> Int? {
//        return self.countries[index].population 
//    }
}
