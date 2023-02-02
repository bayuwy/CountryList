//
//  CountriesViewModel.swift
//  CobaLogin
//
//  Created by developer on 27/01/23.
//

import Foundation

class CountriesViewModel {
    private var countries: [Countries] = []
    
    func fetch() {
        CountriesAPI.fetchData { countries in
            self.countries = countries
            dump(self.countries)
            DispatchQueue.main.async
            {
                self.countries.sort(by: {$0.name!.common < $1.name!.common})
            }
        }
    }
    
    func numberOrRows() -> Int {
        return self.countries.count
    }
    
    func countryName(at index: Int) -> String? {
        return self.countries[index].name?.common ?? ""
    }
    func countryFlag(at index: Int) -> String? {
        return self.countries[index].flags.png!
    }
}
