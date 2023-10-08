//
//  Presenter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import Foundation

protocol IMoviesDetailViewPresenterInput {
    
}

typealias IMoviesDetailViewPresenterOutput = IMoviesDetailViewControllerInput

final class MoviesDetailViewPresenter {
    // MARK: Properties
    private weak var output: IMoviesDetailViewPresenterOutput?
    
    init(output: IMoviesDetailViewPresenterOutput) {
        self.output = output
    }
}

extension MoviesDetailViewPresenter: IMoviesDetailViewPresenterInput {
}

