import UIKit

class WatchedFilmController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var filmImageView: URLUIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var btnScore1: UIButton!
    @IBOutlet weak var btnScore2: UIButton!
    @IBOutlet weak var btnScore3: UIButton!
    @IBOutlet weak var btnScore4: UIButton!
    @IBOutlet weak var btnScore5: UIButton!
    @IBOutlet weak var score1ImageView: UIImageView!
    @IBOutlet weak var score2ImageView: UIImageView!
    @IBOutlet weak var score3ImageView: UIImageView!
    @IBOutlet weak var score4ImageView: UIImageView!
    @IBOutlet weak var score5ImageView: UIImageView!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    
    
    var film: ManagedFilm!
    var parent: ListController!
    let star = UIImage(named: "star.png")
    let star1 = UIImage(named: "star1.png")
    
    override func viewDidLoad() {
        title = film.title
        titleLabel.text = film.title
        stars(film.score)
        descriptionLabel.text = film.overview
        filmImageView.setImages(film.imageUrl, defaultImg: nil)
        setScore(film.userScore)
        if let trailerId = film.trailer {
            playerView.loadWithVideoId(trailerId)
            
            descriptionLabel.sizeToFit()
            let size  = descriptionLabel.frame.height
            if size > 41 {
                self.contentHeightConstraint.constant = self.contentHeightConstraint.constant + size
            }
        }
    }
    
    @IBAction func remove() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        context.deleteObject(film)
        
        do{
            try context.save()
        }catch _ as NSError{  }

        self.parent.reload()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func score1(sender: AnyObject) {
        setScore(1)
    }
    @IBAction func score2(sender: AnyObject) {
        setScore(2)
    }
    @IBAction func score3(sender: AnyObject) {
        setScore(3)
    }
    @IBAction func score4(sender: AnyObject) {
        setScore(4)
    }
    @IBAction func score5(sender: AnyObject) {
        setScore(5)
    }
    
    func setScore(score: Float) {
        film.userScore = score
        let star = UIImage(named: "Star")
        let star1 = UIImage(named: "Star1")
        
        btnScore1.setBackgroundImage(star, forState: .Normal)
        btnScore2.setBackgroundImage(star, forState: .Normal)
        btnScore3.setBackgroundImage(star, forState: .Normal)
        btnScore4.setBackgroundImage(star, forState: .Normal)
        btnScore5.setBackgroundImage(star, forState: .Normal)
        
        if score >= 1 {
            btnScore1.setBackgroundImage(star1, forState: .Normal)
        }
        if score >= 2 {
            btnScore2.setBackgroundImage(star1, forState: .Normal)
        }
        if score >= 3 {
            btnScore3.setBackgroundImage(star1, forState: .Normal)
        }
        if score >= 4 {
            btnScore4.setBackgroundImage(star1, forState: .Normal)
        }
        if score >= 5 {
            btnScore5.setBackgroundImage(star1, forState: .Normal)
        }
        saveFilm()
    }
    
    func saveFilm() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        do{
            try context.save()
        }catch _ as NSError{ }
    }
    
    func stars(score: Float) {
        let starScore = round(score / 2)
        let star = UIImage(named: "Star")
        let star1 = UIImage(named: "Star1")
        
        score1ImageView.image = star
        score2ImageView.image = star
        score3ImageView.image = star
        score4ImageView.image = star
        score5ImageView.image = star
        
        if starScore >= 1 {
            score1ImageView.image = star1
        }
        if starScore >= 2 {
            score2ImageView.image = star1
        }
        if starScore >= 3 {
            score3ImageView.image = star1
        }
        if starScore >= 4 {
            score4ImageView.image = star1
        }
        if starScore >= 5 {
            score5ImageView.image = star1
        }
    }
}