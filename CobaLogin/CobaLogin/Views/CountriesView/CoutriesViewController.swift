//
//  CoutriesViewController.swift
//  CobaLogin
//
//  Created by developer on 26/01/23.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher


class CoutriesViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var countries: [Countries] = []
    var countriesVM = CountriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        countriesVM.fetch()
        fetch()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    func fetch() {
        CountriesAPI.fetchData { countries in
            self.countries = countries
            dump(self.countries)
            DispatchQueue.main.async
            {
                self.countries.sort(by: {$0.name!.common < $1.name!.common})
                self.tableView.reloadData()
            }
        }
    }
}




// MARK: - UITableViewDataSource
extension CoutriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return countries.count
//        return countriesVM.numberOrRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countriesCellId", for: indexPath) as! CountriesViewCell
        
        let index = countries[indexPath.row]
        cell.countryName.text = index.name?.common ?? ""
        cell.countryImageView.kf.setImage(with: URL(string: index.flags.png!))
        
//        let index = indexPath.row
//        cell.countryName.text = countriesVM.countryName(at: index)
//        cell.countryImageView.kf.setImage(with: URL(string: countriesVM.countryFlag(at: index)!))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CoutriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "DetailCountry", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "detailCountry") as? DetailCountryViewController {
//
//            let index = countries[indexPath.row]
//            vc.nameCountry = ": \(index.name?.common ?? "")"
//            vc.capitalCountry = ": \(index.capital?.last ?? "")"
//            vc.langCountry = ": \(index.languages ?? [:])"
//            vc.regionCountry = ": \(index.region ?? "")"
//            vc.subRegionCountry = ": \(index.subregion ?? "")"
//            vc.populationCountry = ": \(index.population ?? 0)"


            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


}
