import UIKit

class WatchedFilmController: UIViewController {
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
        let star = UIImage(named: "star")
        let star1 = UIImage(named: "star1")
        
        switch score {
        case 1:
            btnScore1.setBackgroundImage(star1, forState: .Normal)
            btnScore2.setBackgroundImage(star, forState: .Normal)
            btnScore3.setBackgroundImage(star, forState: .Normal)
            btnScore4.setBackgroundImage(star, forState: .Normal)
            btnScore5.setBackgroundImage(star, forState: .Normal)
        case 2:
            btnScore1.setBackgroundImage(star1, forState: .Normal)
            btnScore2.setBackgroundImage(star1, forState: .Normal)
            btnScore3.setBackgroundImage(star, forState: .Normal)
            btnScore4.setBackgroundImage(star, forState: .Normal)
            btnScore5.setBackgroundImage(star, forState: .Normal)
        case 3:
            btnScore1.setBackgroundImage(star1, forState: .Normal)
            btnScore2.setBackgroundImage(star1, forState: .Normal)
            btnScore3.setBackgroundImage(star1, forState: .Normal)
            btnScore4.setBackgroundImage(star, forState: .Normal)
            btnScore5.setBackgroundImage(star, forState: .Normal)
        case 4:
            btnScore1.setBackgroundImage(star1, forState: .Normal)
            btnScore2.setBackgroundImage(star1, forState: .Normal)
            btnScore3.setBackgroundImage(star1, forState: .Normal)
            btnScore4.setBackgroundImage(star1, forState: .Normal)
            btnScore5.setBackgroundImage(star, forState: .Normal)
        case 5:
            btnScore1.setBackgroundImage(star1, forState: .Normal)
            btnScore2.setBackgroundImage(star1, forState: .Normal)
            btnScore3.setBackgroundImage(star1, forState: .Normal)
            btnScore4.setBackgroundImage(star1, forState: .Normal)
            btnScore5.setBackgroundImage(star1, forState: .Normal)
        default:
            btnScore1.setBackgroundImage(star, forState: .Normal)
            btnScore2.setBackgroundImage(star, forState: .Normal)
            btnScore3.setBackgroundImage(star, forState: .Normal)
            btnScore4.setBackgroundImage(star, forState: .Normal)
            btnScore5.setBackgroundImage(star, forState: .Normal)
        }
        print (film.userScore)
        saveFilm()
    }
    
    func saveFilm() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        
        do{
            try context.save()
        }catch _ as NSError{
            //TODO smth :p
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