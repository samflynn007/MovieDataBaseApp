//
//  SearchResultsViewController.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import UIKit

protocol ISearchResultsViewControllerInput: AnyObject {
   
}

protocol ISearchResultsViewControllerOutput {
    
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ movieModel: MovieDetails)
}


class SearchResultsViewController: UIViewController {

    public var movieData: [MovieDetails] = []
    public weak var delegate: SearchResultsViewControllerDelegate?
    var output: ISearchResultsViewControllerOutput?
    var router: (ISearchResultsViewRoutingLogic & ISearchResultsDataPassing)?
    
    public let searchResultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UINib(nibName: AllMoviesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AllMoviesTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultsTableView.backgroundColor = UIColor(named: Colors.primeColor)
        view.addSubview(searchResultsTableView)
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsTableView.frame = view.bounds
    }

}
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllMoviesTableViewCell.identifier, for: indexPath) as? AllMoviesTableViewCell else { return UITableViewCell() }
        let movie = movieData[indexPath.row]
        cell.backgroundColor  = UIColor(named: Colors.primeColor)
        cell.configure(movieDetail: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = movieData[indexPath.row]
        self.delegate?.searchResultsViewControllerDidTapItem(movie)
        
        
    }
}
extension SearchResultsViewController: ISearchResultsViewControllerInput {
    
}
