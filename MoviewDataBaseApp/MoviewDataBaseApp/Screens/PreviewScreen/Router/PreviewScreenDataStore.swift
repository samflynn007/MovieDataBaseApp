//
//  PreviewScreenDataStore.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

protocol IPreviewScreenDataStore {
    var movieDetail: MovieDetails? { get set }
   
    
}

final class DefaultPreviewScreenDataStore: IPreviewScreenDataStore {
    var movieDetail: MovieDetails?
    

//    var movieDetails: [MovieDetails]?
}
