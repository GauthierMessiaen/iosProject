import UIKit
import CoreData

class FilmController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filmImageView: URLUIImageView!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var score1ImageView: UIImageView!
    @IBOutlet weak var score2ImageView: UIImageView!
    @IBOutlet weak var score3ImageView: UIImageView!
    @IBOutlet weak var score4ImageView: UIImageView!
    @IBOutlet weak var score5ImageView: UIImageView!
    
    var film: Film!
    var watchListController: ListController!
    
    override func viewDidLoad() {
        title = film.title
        titleLabel.text = film.title
        stars(film.score)
        descriptionLabel.text = film.overview
        filmImageView.setImages(film.imageUrl, defaultImg: nil)
    }
    
    @IBAction func addToList() {
        if watchListController.movieAlreadyInList(film) {
            //if movie is already in watchlist, show a message and dont add the movie
            let alertController = UIAlertController(title: "Movie already added", message:
                "This movie is already to your list", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            _ = ManagedFilm(film: film)
            self.watchListController.reload()
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    
    
    func stars(score: Float) {
        let starScore = round(score / 2)
        let star = UIImage(named: "star")
        let star1 = UIImage(named: "star1")
        switch starScore {
        case 1:
            score1ImageView.image = star1
            score2ImageView.image = star
            score3ImageView.image = star
            score4ImageView.image = star
            score5ImageView.image = star
        case 2:
            score1ImageView.image = star1
            score2ImageView.image = star1
            score3ImageView.image = star
            score4ImageView.image = star
            score5ImageView.image = star
        case 3:
            score1ImageView.image = star1
            score2ImageView.image = star1
            score3ImageView.image = star1
            score4ImageView.image = star
            score5ImageView.image = star
        case 4:
            score1ImageView.image = star1
            score2ImageView.image = star1
            score3ImageView.image = star1
            score4ImageView.image = star1
            score5ImageView.image = star
        case 5:
            score1ImageView.image = star1
            score2ImageView.image = star1
            score3ImageView.image = star1
            score4ImageView.image = star1
            score5ImageView.image = star1
        default:
            score1ImageView.image = star
            score2ImageView.image = star
            score3ImageView.image = star
            score4ImageView.image = star
            score5ImageView.image = star
        }
    }
}