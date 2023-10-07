//
//  Configurator.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//

import Foundation

struct MoviesConfigurator {
    static func configureMoviesView(viewController: MoviesViewController) {
        let dataStore = DefaultMovieDataStore()
        let router = MoviesViewRouter(dataStore: dataStore)
        router.viewController = viewController
        
        let presenter = MoviesViewPresenter(output: viewController)
        let worker    = MoviesViewWorker()
        
        let interactorDependency = MoviesViewInteractor.Dependency(worker: worker, output: presenter)
        let interactor = MoviesViewInteractor(with: interactorDependency)
        
        viewController.output = interactor
        viewController.router = router
    }
}
