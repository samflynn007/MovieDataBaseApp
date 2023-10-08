//
//  PreviewScreenRouter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import Foundation
protocol IPreviewScreenViewRoutingLogic {
    func navigateToMovieDetailScreen(with data: MovieDetails)
    
}

protocol IPreviewScreenDataPassing {
    var dataStore: IPreviewScreenDataStore { get set }
}

final class PreviewScreenViewRouter: IPreviewScreenViewRoutingLogic, IPreviewScreenDataPassing {
   
    

    // MARK: - Variables
    weak var viewController: PreviewViewController?
    var dataStore: IPreviewScreenDataStore
    //
    init(dataStore: IPreviewScreenDataStore) {
        self.dataStore = dataStore
    }
}

extension PreviewScreenViewRouter {
    
    func navigateToMovieDetailScreen(with data: MovieDetails) {
        guard let movieDetailVC = MoviesDetailViewController.instance() as? MoviesDetailViewController else { return }
        movieDetailVC.router?.dataStore.movieDetail = data
        movieDetailVC.movieData = data
        viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
