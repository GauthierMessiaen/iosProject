import Foundation
import UIKit

class addFilmController: UITableViewController, UISearchResultsUpdating {
    @IBOutlet weak var table: UITableView!
    
    var completeList = [
        Film(title: "Star Wars", description: "This is not the description you're looking for", score: 9, userScore: 10),
        Film(title: "Lord of the Rings", description: "and my axe,... i mean description", score: 10, userScore: 9),
        Film(title: "The worst movie", description: "yep, the wrst movie there is", score: 1, userScore: 3)
    ]
    
    var searchActive = false
    var filteredData : [Film] = []
    var searchController = UISearchController(searchResultsController: nil)
    
    var api: APIController = APIController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        api.GetAPIResultsAsync("http://api.themoviedb.org/3/search/movie?api_key=860d7a52308bfdd68825f10b030d9430&query=star")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("filmCell", forIndexPath: indexPath) as! FilmTableViewCell
        
        if searchController.active && searchController.searchBar.text != "" {
            cell.titleLabel?.text = filteredData[indexPath.row].title
            cell.descriptionLabel?.text = filteredData[indexPath.row].description
        } else {
            cell.titleLabel?.text = completeList[indexPath.row].title
            cell.descriptionLabel?.text = completeList[indexPath.row].description
        }
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filteredData = completeList.filter { film in
            let title = film.title.lowercaseString.containsString(searchController.searchBar.text!.lowercaseString)
            let description = film.description.lowercaseString.containsString(searchController.searchBar.text!.lowercaseString)
            return(title || description)
        }
        
        tableView.reloadData()
    }
    
}