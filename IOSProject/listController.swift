import UIKit


class listController: UITableViewController {
    @IBOutlet weak var table: UITableView!
    
    var watchlist: [Film] = []
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
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
        let film = watchlist[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("filmCell", forIndexPath: indexPath) as! FilmTableViewCell
        
        cell.titleLabel?.text = film.title
        cell.descriptionLabel?.text = film.description
        cell.filmImageView.setImages(film.imageUrl, defaultImg: nil)
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "showDetailsSegue") {
            if let destinationVC = segue.destinationViewController as? filmController {
                destinationVC.film = watchlist[(self.tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
}
