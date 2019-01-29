//
//  CountryDetailsViewController.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 29.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

class CountryDetailsViewController: UIViewController {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var regionBlocks: UILabel!
    @IBOutlet weak var languages: UILabel!
    @IBOutlet weak var currency: UILabel!

    private let viewModel: CountryDetailsViewModel

    init(viewModel: CountryDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    private func setupUI() {

    }
}

struct CountryDetailsViewModel {
    let name: String
    let population: String
    let capital: String
    let region: String
    let regionBlocks: String
    let languages: String
    let currency: String

    init(country: Country) {
        name = country.name
        population = country.population?.string ?? "N/A"
        capital = country.capitalCity ?? "N/A"
        languages = country.languages?.joined(separator: ", ") ?? "N/A"
        region = "N/A"
        regionBlocks = "N/A"
        currency = "N/A"
    }
}

private extension Int {
    var string: String {
        return "\(self)"
    }
}
