//
//  CountriesViewModel.swift
//  CobaLogin
//
//  Created by developer on 27/01/23.
//

import Foundation

class CountriesViewModel {
    var countries: [Countries] = []
    
    func fetch(completion: @escaping () -> ()) {
        CountriesAPI.fetchData { countries in
            self.countries = countries
            dump(self.countries)
            DispatchQueue.main.async
            {
                self.countries.sort(by: {$0.name?.common ?? "" < $1.name?.common ?? ""})
            }
            completion()
        }
    }
    
    func numberOrRows() -> Int {
        return self.countries.count
    }
    
    func countryName(at index: Int) -> String? {
        return self.countries[index].name?.common
    }
    
    func countryFlag(at index: Int) -> String? {
        return self.countries[index].flags.png!
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
