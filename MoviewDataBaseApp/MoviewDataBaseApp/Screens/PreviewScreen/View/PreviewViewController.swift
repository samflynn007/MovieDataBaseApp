//
//  PreviewViewController.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import UIKit

protocol IPreviewScreenViewControllerInput: AnyObject {
   
}

protocol IPreviewScreenViewControllerOutput {
    
}

class PreviewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movieDetails: [MovieDetails] = []
    var output: IPreviewScreenViewControllerOutput?
    var router: (IPreviewScreenViewRoutingLogic & IPreviewScreenDataPassing)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie List (\(movieDetails.count))"
        tableView.register(UINib(nibName: AllMoviesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AllMoviesTableViewCell.identifier)
        PreviewScreenConfigurator.configureMoviesView(viewController: self)
         
    }
    

    

}
extension PreviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllMoviesTableViewCell.identifier, for: indexPath) as? AllMoviesTableViewCell else { return UITableViewCell() }
        let movie = movieDetails[indexPath.row]
        cell.configure(movieDetail: movie)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieDetails[indexPath.row]
        router?.navigateToMovieDetailScreen(with: movie)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension PreviewViewController: IPreviewScreenViewControllerInput {
    
}
