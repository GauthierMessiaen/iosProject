import UIKit

class watchedFilmController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filmImageView: URLUIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var yourScoreLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var film: Film!
    
    override func viewDidLoad() {
        title = film.title
        titleLabel.text = film.title
        scoreLabel.text = film.scoreToStars(film.score)
        yourScoreLabel.text = film.scoreToStars(film.userScore!)
        descriptionLabel.text = film.description
        filmImageView.setImages(film.imageUrl, defaultImg: nil)
    }
    
    @IBAction func AddToList() {
        
    }
}