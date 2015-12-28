import Foundation
import UIKit

struct Film {
    var title: String
    var description: String
    var score: Int
    var userScore: Int? = nil
    var imageUrl: String? = nil
    
    init(json: NSDictionary){
        self.title = json["title"] as! String
        self.description = json["overview"] as! String
        self.score = json["vote_average"] as! Int
        self.imageUrl = "http://image.tmdb.org/t/p/w300\(json["poster_path"]!)"
    }
    
    init(title: String, description: String, score: Int, userScore: Int?){
        self.title = title
        self.description = description
        self.score = score
        self.userScore = userScore
    }
    
    func scoreToStars(score: Int) -> String{
        var stars: String = ""
        for var i = 0; i < score/2; i++ {
            stars.append("⭐️")
        }
        
        return stars
    }
}
