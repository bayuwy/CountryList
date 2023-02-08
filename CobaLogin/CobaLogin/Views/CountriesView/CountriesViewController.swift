//
//  CountriesViewController.swift
//  CobaLogin
//
//  Created by developer on 26/01/23.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher


class CountriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var refreshControl: UIRefreshControl!
    
    private let disposeBag = DisposeBag()
    var countriesVM = CountriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
        
        fecthCountryList()
    }
    
    func setup() {
        title = "Country List"
        
//        let tableView = UITableView(frame: .zero)
//        view.addSubview(tableView)
//        self.tableView = tableView
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
        
        let nib = UINib(nibName: "CountriesViewCell", bundle: Bundle(for: CountriesViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: "countriesCellId")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
        
        let refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        self.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    func bindViewModel() {
        countriesVM.countryList.subscribe { [weak self] (event) in
            self?.tableView.reloadData()
        }
        .disposed(by: disposeBag)
        
        countriesVM.isLoading.subscribe { [weak self] (event) in
            switch event {
            case .next(let value):
                if value {
                    self?.refreshControl.beginRefreshing()
                }
                else {
                    self?.refreshControl.endRefreshing()
                }
            default:
                break
            }
        }
        .disposed(by: disposeBag)
    }
    
    @objc func refresh(_ sender: Any) {
        fecthCountryList()
    }
    
    func fecthCountryList() {
        countriesVM.fetchCountries { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}




// MARK: - UITableViewDataSource
extension CountriesViewController: UITableViewDataSource {
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
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "DetailCountry", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "detailCountry") as? DetailCountryViewController {
            
            vc.selectedCountry = countriesVM.countryList.value[indexPath.row]

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
