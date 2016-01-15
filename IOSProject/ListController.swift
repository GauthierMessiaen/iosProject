import UIKit
import CoreData

class ListController: UITableViewController, UISearchResultsUpdating {
    @IBOutlet weak var table: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    var watchlist: [ManagedFilm] = []
    var filteredList : [ManagedFilm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        self.reload()
    }
        
    func reload(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Film")
        if let films = (try? context.executeFetchRequest(fetchRequest)) as? [ManagedFilm]{
            dispatch_async(dispatch_get_main_queue(), {
                self.watchlist = films
                self.tableView.reloadData()
            })
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredList.count
        } else {
            return watchlist.count
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filmCell", forIndexPath: indexPath) as! FilmTableViewCell
        var film: ManagedFilm
        
        if searchController.active && searchController.searchBar.text != "" {
            film = filteredList[indexPath.row]
        } else {
            film = watchlist[indexPath.row]
        }
        cell.titleLabel?.text = film.title
        cell.descriptionLabel?.text = film.overview
        cell.filmImageView.setImages(film.imageUrl, defaultImg: nil)
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetailsSegue") {
            let film = watchlist[(self.tableView.indexPathForSelectedRow?.row)!]
            
            if let destinationVC = segue.destinationViewController as? WatchedFilmController {
                destinationVC.parent = self
                destinationVC.film = film
            }
        }else if(segue.identifier == "addFilm") {
            if let destinationVC = segue.destinationViewController as? AddFilmController {
                destinationVC.watchListController = self
            }
        }
    }
    
    func movieAlreadyInList(film: Film) -> Bool {
        for movie in watchlist {
            if movie.tmdbID == film.tmdbID {
                return true
            }
        }
        
        return false
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredList = watchlist.filter { film in
            return film.title.lowercaseString.containsString(searchController.searchBar.text!.lowercaseString)
        }
        tableView.reloadData()
    }
}
