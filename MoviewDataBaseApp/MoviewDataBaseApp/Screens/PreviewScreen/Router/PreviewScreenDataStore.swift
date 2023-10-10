//
//  PreviewScreenDataStore.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

// MARK: Data Handler Protocol
protocol IPreviewScreenDataStore {
    var movieDetail: [MovieDetails]? { get set }
}

final class DefaultPreviewScreenDataStore: IPreviewScreenDataStore {
    var movieDetail: [MovieDetails]?
}
