//
//  DetailCountryViewController.swift
//  CobaLogin
//
//  Created by developer on 26/01/23.
//

import UIKit
import Foundation
import Kingfisher

class DetailCountryViewController: UIViewController {

    @IBOutlet weak var artCountry: UIImageView!
    @IBOutlet weak var nameCountryLabel: UILabel!
    @IBOutlet weak var capitalCountryLabel: UILabel!
    @IBOutlet weak var langCountryLabel: UILabel!
    @IBOutlet weak var regionCountryLabel: UILabel!
    @IBOutlet weak var subRegionCountryLabel: UILabel!
    @IBOutlet weak var populationCountryLabel: UILabel!
    
    var selectedCountry: Countries?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupDetail()
    }
    
    func setupDetail(){
        artCountry.kf.setImage(with: URL(string: selectedCountry?.coatOfArms.png ?? ""))
        nameCountryLabel.text = ": \(selectedCountry?.name?.common ?? "")"
        capitalCountryLabel.text = ": \(selectedCountry?.capital?.last ?? "")"
        langCountryLabel.text = ": \(selectedCountry?.languages ?? [:])"
        regionCountryLabel.text = ": \(selectedCountry?.region ?? "" )"
        subRegionCountryLabel.text = ": \(selectedCountry?.subregion ?? "")"
        populationCountryLabel.text = ": \(selectedCountry?.population ?? 0 )"
}

}
