//
//  ViewController.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//

import UIKit

import UIKit

protocol IMoviesViewControllerInput: AnyObject {
    func displayMovieList(movieDetails: [MovieDetails])
    func displaySectionList(sectionMoview: [Section<Any>])
}

protocol IMoviesViewControllerOutput {
    func fetchMoviesData()
    func fetchSectionData()
}


final class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var output: IMoviesViewControllerOutput?
    var router: (IMoviesViewRoutingLogic & IMoviesDataPassing)?
    
    private var movies: [MovieDetails] = []
    private var moviesSections: [Section<Any>] = []
    var filteredMovies: [MovieDetails] = []
    
    private let searchController: UISearchController = {
        
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search For a Movie or a TV Show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
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
        // Do any additional setup after loading the view.
        output?.fetchMoviesData()
        output?.fetchSectionData()
        navigationItem.searchController = searchController
        self.tableView.register(UINib(nibName: "AllMoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllMoviesTableViewCell")

        searchController.searchResultsUpdater = self
    }


    func configure() {
        MoviesConfigurator.configureMoviesView(viewController: self)
    }
}

extension MoviesViewController: IMoviesViewControllerInput {
    func displaySectionList(sectionMoview: [Section<Any>]) {
        moviesSections = sectionMoview
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(moviesSections[0])
    }
    
    func displayMovieList(movieDetails: [MovieDetails]) {
       movies = movieDetails
    }
    
}
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        moviesSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if moviesSections[section].expanded == true {
            return moviesSections[section].listData.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllMoviesTableViewCell") as! AllMoviesTableViewCell
            cell.configure(movieDetail: (moviesSections[indexPath.section].listData[indexPath.row] as? MovieDetails)!)
            return cell
        default :
            guard  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
            cell.textLabel?.text = moviesSections[indexPath.section].listData[indexPath.row] as? String
            return cell
            
        }
        
       
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        header.button.setTitle(moviesSections[section].title, for: .normal)
        header.delegate = self
        header.section = section
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if moviesSections[indexPath.section].expanded {
            return UITableView.automaticDimension
        } else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 {
            router?.navigateToMovieDetailScreen(for: (moviesSections[indexPath.section].listData[indexPath.row] as? MovieDetails)!)
        } else if let filteredMovie = getSectionWiseData(secInd: indexPath.section, compareValue: moviesSections[indexPath.section].listData[indexPath.row] as! String) {
            router?.navigateToPreViewController(for: filteredMovie)
//            navigate(list: filteredMovie)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getSectionWiseData(secInd: Int, compareValue: String) -> [MovieDetails]? {
            switch secInd {
            case 0:
                return movies.filter({$0.Year.components(separatedBy: "-").contains(compareValue)})
            case 1:
                return movies.filter({$0.Genre.components(separatedBy: ",").contains(compareValue)})
            case 2:
                return movies.filter({$0.Director.components(separatedBy: ",").contains(compareValue)}).sorted()
            case 3:
                return movies.filter({$0.Actors.components(separatedBy: ",").contains(compareValue)})
            default:
                return nil
            }
        }
    }
    
  
extension MoviesViewController: HeaderDelegate {
    func callHeader(index: Int) {
        
        moviesSections[index].expanded = !moviesSections[index].expanded
        tableView.reloadSections([index], with: .automatic)
    }
    
    
}

extension MoviesViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= 2, let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        resultsController.delegate = self
        filteredMovies = movies.filter { movie in
            return movie.Title.lowercased().contains(query.lowercased()) ||
            movie.Genre.lowercased().contains(query.lowercased()) ||
            movie.Director.lowercased().contains(query.lowercased()) ||
            movie.Actors.lowercased().contains(query.lowercased())
        }
        DispatchQueue.main.async { [weak self] in
            resultsController.movieData = self?.filteredMovies ?? []
            resultsController.searchResultsTableView.reloadData()
        }
    }
    func searchResultsViewControllerDidTapItem(_ movieModel: MovieDetails) {
        router?.navigateToMovieDetailScreen(for: movieModel)
    }
        
    }
