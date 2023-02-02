//
//  DetailCountryViewController.swift
//  CobaLogin
//
//  Created by developer on 26/01/23.
//

import UIKit
import Foundation

class DetailCountryViewController: UIViewController {

    @IBOutlet weak var nameCountryLabel: UILabel!
    @IBOutlet weak var capitalCountryLabel: UILabel!
    @IBOutlet weak var langCountryLabel: UILabel!
    @IBOutlet weak var regionCountryLabel: UILabel!
    @IBOutlet weak var subRegionCountryLabel: UILabel!
    @IBOutlet weak var populationCountryLabel: UILabel!
    
    var nameCountry = ""
    var capitalCountry = ""
    var langCountry = ""
    var regionCountry = ""
    var subRegionCountry = ""
    var populationCountry = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        nameCountryLabel.text = nameCountry
        capitalCountryLabel.text = capitalCountry
        langCountryLabel.text = langCountry
        regionCountryLabel.text = regionCountry
        subRegionCountryLabel.text = subRegionCountry
        populationCountryLabel.text = populationCountry
    }

}
