import UIKit
import CoreData

class ListController: UITableViewController {
    @IBOutlet weak var table: UITableView!
    
    var watchlist: [ManagedFilm] = []
    
    override func viewWillAppear(animated: Bool) {
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
        return watchlist.count
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filmCell", forIndexPath: indexPath) as! FilmTableViewCell
        let film = watchlist[indexPath.row]
        
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
    
}
