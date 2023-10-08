//
//  MoviesDetailRouter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import Foundation

protocol IMoviesDetailViewRoutingLogic {
    func navigateToRating()
}

protocol IMoviesDetailDataPassing {
    var dataStore: IMovieDetailDataStore { get set }
}

final class MoviesDetailViewRouter: NSObject, IMoviesDetailViewRoutingLogic, IMoviesDetailDataPassing {
    

    // MARK: - Variables
    weak var viewController: MoviesDetailViewController?
    var dataStore: IMovieDetailDataStore
    
    init(dataStore: IMovieDetailDataStore) {
        self.dataStore = dataStore
    }
    
}

//    MARK: - Routing Methods

extension MoviesDetailViewRouter {
    func navigateToRating() {
        guard let movieDetailVC = RatingViewController.instance() as? RatingViewController else { return }
        viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
    }

}


