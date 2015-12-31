import Foundation
import CoreData
import UIKit

// not sure is the best way to do it but i think is good :)
class ManagedFilm: NSManagedObject {
    @NSManaged var tmdbID: Int
    @NSManaged var title: String
    @NSManaged var overview: String
    @NSManaged var score: Float
    @NSManaged var userScore: Float
    @NSManaged var imageUrl: String?
    
    
    convenience init(film: Film){
        let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName("Film", inManagedObjectContext: managedContext)!
        self.init(entity: entity, insertIntoManagedObjectContext: managedContext)
        
        tmdbID = film.tmdbID
        title = film.title
        overview = film.overview
        score = film.score
        userScore = film.userScore
        imageUrl = film.imageUrl
        
        do{
            try managedContext.save()
        }catch _ as NSError{
                
        }
        
    }
}
