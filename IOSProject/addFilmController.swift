import Foundation
import UIKit

class addFilmController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var completeList = [
        Film(title: "Star Wars", description: "This is not the description you're looking for", score: 9, userScore: 10),
        Film(title: "Lord of the Rings", description: "and my axe,... i mean description", score: 10, userScore: 9),
        Film(title: "The worst movie", description: "yep, the wrst movie there is", score: 1, userScore: 3)
    ]
    
    var searchActive = false
    var filteredData : [Film] = []
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredData.count
        } else {
            return completeList.count
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filmCell") as! FilmTableViewCell
        
        if searchActive {
            cell.titleLabel?.text = filteredData[indexPath.row].title
            cell.descriptionLabel?.text = filteredData[indexPath.row].description
        } else {
            cell.titleLabel?.text = completeList[indexPath.row].title
            cell.descriptionLabel?.text = completeList[indexPath.row].description
        }
        
        return cell
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = completeList.filter({ (text) -> Bool in
            let tmp: NSString = text.title
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filteredData.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
}