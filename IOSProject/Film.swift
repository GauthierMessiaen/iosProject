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
    var trailer: String?
    
    init(json: NSDictionary){
        tmdbID = json["id"] as! Int
        title = json["title"] as! String
        self.overview = json["overview"] as! String
        self.score = json["vote_average"] as! Float
        self.userScore = 0
        self.imageUrl = "http://image.tmdb.org/t/p/w300\(json["poster_path"]!)"
        TMDBApiClient.instance.getTrailers(tmdbID, success: getTrailers)
    }
    
    func getTrailers(data: NSData){
        var trailerCounter = 1
        if let jsonMovies: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary{
            if let results = jsonMovies["results"] as? NSArray{
                
                //De eerste trailer uit de lijst selecteren die op youtube staat
                for var i = 0; i < trailerCounter; i++ {
                    if i < results.count {
                        if results[i]["site"] as! String == "YouTube" {
                            trailer = results[i]["key"] as! String
                        } else {
                            trailerCounter++
                        }
                    }
                }
            }
        }
    }
    
}
