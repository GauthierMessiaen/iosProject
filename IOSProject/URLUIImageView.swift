//Source: Kennis
import Foundation
import UIKit

class URLUIImageView: UIImageView{
    var url: String?{
        didSet{
            if url != nil{
                ImageCache.instance.load(self)
            }
        }
    }
    
    func setImages(urlImg: String?, defaultImg: UIImage?){
        self.image = defaultImg
        self.url = urlImg
    }
}