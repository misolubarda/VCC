//
//  CountriesListViewController.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol CountryListViewControllerDependencies: CountryListDataSourceDependencies {}

class CountryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let dataSource: CountryListDataSource

    init(dependencies: CountryListViewControllerDependencies) {
        dataSource = CountryListDataSource(dependencies: dependencies)
        super.init(nibName: nil, bundle: nil)
        dataSource.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearchController()
        dataSource.fetch(term: nil)
    }

    private func setupTableView() {
        tableView.register(for: CountryListCell.self)
        tableView.dataSource = dataSource
    }

    private func setupSearchController() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchResultsUpdater = self
        definesPresentationContext = true
    }
}

extension CountryListViewController: CountryListDataSourceFeedback {
    func countryListDataSourceDidUpdate() {
        tableView.reloadData()
    }

    func countryListDataSourceFailedUpdate() {
        tableView.reloadData()
    }
}

extension CountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
