//
//  ViewController.swift
//  Code Challenge
//
//  Copyright © 2019 Code Coding Challenge. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    private let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .whiteLarge)
        view.color = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let dataSource = StoriesDataSource()
    private let imageLoader = ImageLoader()
    
    override public func loadView() {
        super.loadView()
        self.view = tableView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = "Stories"

        setupNavigationController()
        setupTableView()
        setupIndicator()
        setupDataSource()
        setupSearchController()
        
        dataSource.load()
    }
    
    private func setupNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.orangeColor
        ]
    }
    
    private func setupTableView() {
        self.tableView.register(
            UINib(nibName: "StoryTableViewCell", bundle: Bundle(for: StoryTableViewCell.self)), forCellReuseIdentifier: StoryTableViewCell.reuseIdentifier
        )
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func setupIndicator() {
        self.view.addSubview(self.indicator)
        self.view.bringSubviewToFront(self.indicator)
        NSLayoutConstraint.activate([
            self.indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
    }
    
    private func setupDataSource() {
        self.indicator.startAnimating()
        dataSource.didLoadData = { [weak tableView, indicator] in
            indicator.stopAnimating()
            tableView?.reloadData()
        }
    }
    
    private func setupSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search for a Story"
        search.searchBar.tintColor = .orangeColor
        navigationItem.searchController = search
        self.definesPresentationContext = true
    }
}

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryTableViewCell.reuseIdentifier, for: indexPath) as? StoryTableViewCell else {
            return UITableViewCell()
        }
        
        let item = dataSource.item(at: indexPath.row)
        cell.titleLabel.text = item.title
        cell.authorLabel.text = item.user.name
        
        imageLoader.loadImage(from: item.cover) { image in
            DispatchQueue.main.async {
                cell.coverImageView.image = image
                cell.setNeedsLayout()
            }
        }
        
        imageLoader.loadImage(from: item.user.avatar) { image in
            DispatchQueue.main.async {
                cell.authorAvatarImageView.image = image
                cell.setNeedsLayout()
            }
        }
        
        cell.didTapCoverImage = {
            print("tap cover image")
        }
        
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        dataSource.searchBy(title: text) {
            tableView.reloadData()
        }
    }
}

extension ViewController: UIScrollViewDelegate, UITableViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.bounds.size.height >= scrollView.contentSize.height {
            dataSource.loadNext()
        }
    }
}
