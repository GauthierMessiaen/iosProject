import UIKit

class listController: UITableViewController {
    @IBOutlet weak var table: UITableView!
    
    var watchlist: [Film] = [
        Film(title: "Star Wars", description: "This is not the description you're looking for", score: 9, userScore: 10),
        Film(title: "Lord of the Rings", description: "and my axe,... i mean description", score: 10, userScore: 9)
    ]
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        
        TMDBApiClient.instance.searchMovie("star", success: loadMovies)
    }
    
    func loadMovies(data: NSData){
        print("callback called")
        if let jsonMovies: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary{            print(jsonMovies["page"])
            if let results = jsonMovies["results"] as? NSArray{
                
                var movies: [Film] = []
                
                for movie in results{
                    movies.append(Film(json: movie as! NSDictionary))
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.watchlist = movies
                    self.tableView.reloadData()
                })
            }
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
