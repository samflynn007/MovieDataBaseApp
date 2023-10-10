//
//  ViewController.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//


import UIKit

protocol IMoviesViewControllerInput: AnyObject {
    func displayMovieList(movieDetails: [MovieDetails])
    func displaySectionList(sectionMoview: [Section<Any>])
    func displaySearch(filteredMovies: [MovieDetails])
    func getSectionWiseData(movieDetails: [MovieDetails])
  
}

protocol IMoviesViewControllerOutput {
    func fetchMoviesData()
    func fetchSectionData()
    func getSectionWiseData(secInd: IndexPath, data: [Section<Any>],movies: [MovieDetails])
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
        controller.searchBar.placeholder = Home.searchPlaceholderText
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
        title = "Movie Categories"
        setUpHomeView()
        navigationSetUp()
        
    }
    // MARK: - Custom Methods
    
    func navigationSetUp() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(named: Colors.primeColor)
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }

    func configure() {
        MoviesConfigurator.configureMoviesView(viewController: self)
       
    }
    func setUpHomeView() {
        output?.fetchMoviesData()
        output?.fetchSectionData()
        view.backgroundColor = UIColor(named: Colors.primeColor)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        self.tableView.register(UINib(nibName: AllMoviesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: AllMoviesTableViewCell.identifier)
        self.tableView.tableFooterView = UIView()

        searchController.searchResultsUpdater = self
    }
}

extension MoviesViewController: IMoviesViewControllerInput {
    
    func displaySearch(filteredMovies: [MovieDetails]) {
        self.filteredMovies = filteredMovies
    }
    
    func displaySectionList(sectionMoview: [Section<Any>]) {
        moviesSections = sectionMoview
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
    
    func displayMovieList(movieDetails: [MovieDetails]) {
       movies = movieDetails
    }
    func getSectionWiseData(movieDetails: [MovieDetails]) {
        filteredMovies = movieDetails
    }
    
}
 // MARK: - TableView Methods

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        moviesSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  moviesSections[section].collapse ? 0: moviesSections[section].listData.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: Home.cellConstant) else { return UITableViewCell() }
        cell.textLabel?.text = moviesSections[indexPath.section].listData[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        header.titleLabel.text = moviesSections[section].title
        header.arrowLabel.text = ">"
        header.setCollapsed(collapsed: moviesSections[section].collapse)
        header.section = section
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return moviesSections[indexPath.section].collapse ? 0 : UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        output?.getSectionWiseData(secInd: indexPath, data: moviesSections, movies: movies)
        router?.navigateToPreViewController(with: filteredMovies)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
}
 
// MARK: HANDLES EXPAND / Collapse
  
extension MoviesViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !moviesSections[section].collapse
        // Toggle collapse
        moviesSections[section].collapse = collapsed
        header.setCollapsed(collapsed: collapsed)
       
        if section.hashValue == MovieSections.allMovies.hashValue {
            print(MovieSections.allMovies.hashValue)
            moviesSections[section].collapse = true
            router?.navigateToPreViewController(with: movies)
            
        }
        // Reload the whole section
        tableView.reloadSections([section], with: .automatic)
    }
    
    func callHeader(index: Int) {
        moviesSections[index].collapse = !moviesSections[index].collapse
        tableView.reloadSections([index], with: .automatic)
    }
    
    
}
// MARK: Search Delegate Methods

extension MoviesViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= Home.minimumSearchLimit, let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
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
        router?.navigateToMovieDetailScreen(with: movieModel)
        
    }
    
}
