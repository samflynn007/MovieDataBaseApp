//
//  MoviesViewRouter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//


import Foundation

protocol IMoviesViewRoutingLogic {
    func navigateToMovieDetailScreen(with data: MovieDetails)
    func navigateToSearchResultsController(with data: [MovieDetails])
    func navigateToPreViewController(with data: [MovieDetails])
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
    
    func navigateToMovieDetailScreen(with data: MovieDetails) {
        guard let movieDetailVC = MoviesDetailViewController.instance() as? MoviesDetailViewController else { return }
        movieDetailVC.router?.dataStore.movieDetail = data
        viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    func navigateToSearchResultsController(with data: [MovieDetails]) {
        let movieResultsVC = SearchResultsViewController()
//        movieResultsVC.movieData = data
        movieResultsVC.router?.dataStore.movieDetails = data
        viewController?.navigationController?.pushViewController(movieResultsVC, animated: true)
    }
    
    func navigateToPreViewController(with data: [MovieDetails]) {
       guard let previewVC = PreviewViewController.instance() as? PreviewViewController else { return }
        previewVC.router?.dataStore.movieDetail = data
//        previewVC.movieDetails = data/
        viewController?.navigationController?.pushViewController(previewVC, animated: true)
        
    }
}

