//
//  MoviesDetailConfigurator.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

struct MoviesDetailConfigurator {
    static func configureMoviesView(viewController: MoviesDetailViewController) {
        let dataStore = DefaultMovieDetailDataStore()
        let router = MoviesDetailViewRouter(dataStore: dataStore)
        router.viewController = viewController
        
        let presenter = MoviesDetailViewPresenter(output: viewController)
        let worker    = MoviesDetailViewWorker()
        
        let interactorDependency = MoviesDetailViewInteractor.Dependency(worker: worker, output: presenter)
        let interactor = MoviesDetailViewInteractor(with: interactorDependency)
        
        viewController.output = interactor
        viewController.router = router
    }
}

