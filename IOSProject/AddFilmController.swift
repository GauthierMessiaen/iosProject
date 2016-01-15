import Foundation
import UIKit
import CoreData

class AddFilmController: UITableViewController, UISearchResultsUpdating {
    @IBOutlet weak var table: UITableView!
    
    var completeList : [Film] = []
    var filteredData : [Film] = []
    var searchController = UISearchController(searchResultsController: nil)
    var watchListController: ListController!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        self.tableView.reloadData()
        TMDBApiClient.instance.searchMovie("",type: "discover" ,success: loadMovies)
    }
    
    func loadMovies(data: NSData){
        if let jsonMovies: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary{
            if let results = jsonMovies["results"] as? NSArray{
                
                var movies: [Film] = []
                
                for movie in results{
                    let film = Film(json: movie as! NSDictionary)
                    //if movie is in watchlist, don't show it again
                    if !watchListController.movieAlreadyInList(film) {
                        movies.append(film)
                    }
                    
                }
                dispatch_async(dispatch_get_main_queue(), {
                    if self.searchController.active && self.searchController.searchBar.text != "" {
                        self.filteredData = movies
                    } else {
                        self.completeList = movies
                    }
                    
                    self.tableView.reloadData()
                })
            }
        }
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredData.count
        } else {
            return completeList.count
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filmCell", forIndexPath: indexPath) as! AllFilmsTableViewCell
        let film : Film!
        if searchController.active && searchController.searchBar.text != "" {
            film = filteredData[indexPath.row]
        } else {
        film = completeList[indexPath.row]
        }
        cell.titleLabel?.text = film.title
        cell.descriptionLabel?.text = film.overview
        cell.filmImageView.setImages(film.imageUrl, defaultImg: nil)
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        TMDBApiClient.instance.searchMovie(searchController.searchBar.text!.lowercaseString, type: "search" ,success: loadMovies)
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetailsSegue") {
            if let destinationVC = segue.destinationViewController as? FilmController {
                destinationVC.watchListController = self.watchListController
                if searchController.active && searchController.searchBar.text != "" {
                    destinationVC.film = filteredData[(self.tableView.indexPathForSelectedRow?.row)!]
                } else {
                    destinationVC.film = completeList[(self.tableView.indexPathForSelectedRow?.row)!]
                }
            }
        }
    }
}