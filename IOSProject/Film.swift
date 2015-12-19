import Foundation
import UIKit

struct Film {
    let title: String
    let description: String
    let score: Int
    let userScore: Int
    //let image: UIImage
    
    init(title: String, description: String, score: Int, userScore: Int/*, image: UIImage*/){
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
