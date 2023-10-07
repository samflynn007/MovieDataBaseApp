//
//  MoviesViewRouter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//


import Foundation

protocol IMoviesViewRoutingLogic {
    func navigateToMovieDetailScreen(for data: MovieDetails)
    func navigateToPreViewController(for data: [MovieDetails])
}

protocol IMoviesDataPassing {
    var dataStore: IMovieDataStore { get set }
}

final class MoviesViewRouter: IMoviesViewRoutingLogic, IMoviesDataPassing {
    
    // MARK: - Variables
    weak var viewController: MoviesViewController?
    var dataStore: IMovieDataStore
    //
    init(dataStore: IMovieDataStore) {
        self.dataStore = dataStore
    }
}

//    MARK: - Routing Methods

extension MoviesViewRouter {
    
    func navigateToMovieDetailScreen(for data: MovieDetails) {
        guard let movieDetailVC = MoviesDetailViewController.instance() as? MoviesDetailViewController else { return }
        movieDetailVC.movieDetail = data
        viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    func navigateToPreViewController(for data: [MovieDetails]) {
        let movieResultsVC = SearchResultsViewController()
        movieResultsVC.movieData = data
        viewController?.navigationController?.pushViewController(movieResultsVC, animated: true)
    }
}

