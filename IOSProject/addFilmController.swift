import Foundation
import UIKit

class addFilmController: UITableViewController {
    @IBOutlet weak var table: UITableView!
    
    var completeList: Array<Film> = [
        Film(title: "Star Wars", description: "This is not the description you're looking for", score: 9, userScore: 10),
        Film(title: "Lord of the Rings", description: "and my axe,... i mean description", score: 10, userScore: 9),
        Film(title: "The worst movie", description: "yep, the wrst movie there is", score: 1, userScore: 3)
    ]
    
    var filteredData = [Film]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completeList.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filmCell", forIndexPath: indexPath) as! FilmTableViewCell
        let film = completeList[indexPath.row]
        
        
        if self.resultSearchController.active {
            cell.titleLabel?.text = filteredData[indexPath.row].title
            cell.descriptionLabel?.text = filteredData[indexPath.row].description
            return cell
        } else {
            cell.titleLabel?.text = film.title
            cell.descriptionLabel?.text = film.description
            
            return cell
        }
    }
    
}