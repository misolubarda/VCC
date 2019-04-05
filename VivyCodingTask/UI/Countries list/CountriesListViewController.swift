//
//  CountriesListViewController.swift
//  VivyCodingTask
//
//  Created by Lubarda, Miso on 28.01.19.
//  Copyright © 2019 Lubarda, Miso. All rights reserved.
//

import UIKit
import DomainLayer

protocol CountryListViewControllerDelegate: class {
    func countryListViewControlleDidSelect(_ country: Country)
}

protocol CountryListViewControllerDependencies: CountryListDataSourceDependencies {}

class CountryListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let dataSource: CountryListDataSource
    weak var delegate: CountryListViewControllerDelegate?

    init(dependencies: CountryListViewControllerDependencies) {
        dataSource = CountryListDataSource(dependencies: dependencies)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Countries"

        setupTableView()
        setupSearchController()
        dataSource.delegate = self
        dataSource.fetch(term: nil)
    }
    
    private func setupTableView() {
        tableView.register(for: CountryListCell.self)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.tableFooterView = UIView()
    }

    private func setupSearchController() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchResultsUpdater = self
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
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

    func countryListDataSourceDidSelect(_ country: Country) {
        delegate?.countryListViewControlleDidSelect(country)
    }
}

extension CountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text, !term.isEmpty {
            dataSource.fetch(term: term)
            return
        }
        dataSource.fetch(term: nil)
    }
}
