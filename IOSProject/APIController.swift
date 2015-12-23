import Foundation
import UIKit

class APIController {
    var delegate:APIControllerProtocol?
    
    func GetAPIResultsAsync(urlString:String) {
        
        let url = NSURL(string: urlString)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        let request = NSURLRequest(URL: url!)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            do {
              if let JSON = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [NSDictionary] {
                    for movie in JSON {
                        let name = movie["name"] as! String
                        print(name)
                    }
                } else {
                    print("NOPE")
                }
                    
            } catch let error as NSError {
                print(error)
            }
        })
        
        task.resume()
    }
}

protocol APIControllerProtocol {
    func JSONAPIResults(results: NSArray)
    
}