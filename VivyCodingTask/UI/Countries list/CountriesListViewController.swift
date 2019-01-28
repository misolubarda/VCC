//
//  CountriesListViewController.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

//    private let dataSource: CountryListDataSource

    init() {
//        dataSource = CountryListDataSource()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    private func setupTableView() {
//        tableView.dataSource = dataSource
    }
}
