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
    
    var countriesVM = CountriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        countriesVM.fetch {
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func setup() {
        let nib = UINib(nibName: "CountriesViewCell", bundle: Bundle(for: CountriesViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "countriesCellId")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
}




// MARK: - UITableViewDataSource
extension CoutriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return countriesVM.numberOrRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countriesCellId", for: indexPath) as! CountriesViewCell
        
        let index = indexPath.row
        cell.countryName.text = countriesVM.countryName(at: index)
        cell.countryImageView.kf.setImage(with: URL(string: countriesVM.countryFlag(at: index)!))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CoutriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "DetailCountry", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "detailCountry") as? DetailCountryViewController {
            
            vc.selectedCountry = countriesVM.countries[indexPath.row]

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
