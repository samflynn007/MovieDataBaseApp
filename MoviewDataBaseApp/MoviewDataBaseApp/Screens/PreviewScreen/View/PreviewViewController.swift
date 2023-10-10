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
    //MARK: Variables

    @IBOutlet weak var tableView: UITableView!
    var movieDetails: [MovieDetails] = []
    var output: IPreviewScreenViewControllerOutput?
    var router: (IPreviewScreenViewRoutingLogic & IPreviewScreenDataPassing)?
    
    
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieData()
        setupUI()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    func configure() {
        PreviewScreenConfigurator.configureMoviesView(viewController: self)

    }
    private func setupMovieData() {
        if let movieDetails  = router?.dataStore.movieDetail {
            self.movieDetails = movieDetails
        }
    }
    
    @objc private func filterData() {
        
//        let sortedItems =  movieDetails.sorted { $0.Title < $1.Title }
        listPopupViewController()
        
    }
    
    func  listPopupViewController() {
        let alert = UIAlertController(title: SortConstants.selectSorting, message: "", preferredStyle: .actionSheet)
        
        let ascendingAction = UIAlertAction(title: SortConstants.ascending, style: .default) {(action) in
            self.sortMovieDetails(ascending: true)
        }
        let descendingAction = UIAlertAction(title: SortConstants.descending, style: .default) {(action) in
            self.sortMovieDetails(ascending: false)
        }
        alert.addAction(ascendingAction)
        alert.addAction(descendingAction)
        
        let cancelAction = UIAlertAction(title: SortConstants.cancel, style: .cancel)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
        
    }
    
    func sortMovieDetails(ascending: Bool) {
        movieDetails.sort { (movie1, movie2) -> Bool in
            if movie1.Title == movie2.Title {
                return ascending ? movie1.Year < movie2.Year : movie1.Year > movie2.Year
            }
            return ascending ? movie1.Title < movie2.Title : movie1.Title > movie2.Title
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupUI() {
        navigationItem.title = "Movie List (\(movieDetails.count))"
        tableView.register(UINib(nibName: AllMoviesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AllMoviesTableViewCell.identifier)
        let barButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterData))
        navigationItem.rightBarButtonItem = barButtonItem
        
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
