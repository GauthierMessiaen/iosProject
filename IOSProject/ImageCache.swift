import Foundation
import UIKit

class ImageCache{
    
    static var instance: ImageCache = ImageCache()
    
    var cache = [String:UIImage]()
    let mainQueue = NSOperationQueue.mainQueue()
    
    private init(){}
    
    func load(let imageView: URLUIImageView){
        if let url = imageView.url{
            if let img = cache[url]{
                imageView.image = img
            }else{
                if let imgUrl = NSURL(string: url){
                    let request: NSURLRequest = NSURLRequest(URL: imgUrl)
                    NSURLConnection.sendAsynchronousRequest(request, queue: mainQueue, completionHandler: {
                        (response, data, error) -> Void in
                        if error == nil {
                            let image = UIImage(data: data!)
                            if image == nil{
                            }else{
                                self.cache[url] = image
                                dispatch_async(dispatch_get_main_queue(), {
                                    if imageView.url == url{ //in case of réusable cell
                                        imageView.image = image
                                    }
                                })
                            }
                        }
                    })
                }
            }
        }
    }
    
}