import Foundation
import CoreData
import UIKit

class Film {
    var tmdbID: Int
    var title: String
    var overview: String
    var score: Float
    var userScore: Float
    var imageUrl: String?
    
    init(json: NSDictionary){
        
        tmdbID = json["id"] as! Int //INT = int 32
        title = json["title"] as! String
        self.overview = json["overview"] as! String
        self.score = json["vote_average"] as! Float
        self.userScore = 0
        self.imageUrl = "http://image.tmdb.org/t/p/w300\(json["poster_path"]!)"
    }
}
