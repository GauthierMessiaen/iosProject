import Foundation
import UIKit

class YoutubeController : UIViewController {
    @IBOutlet weak var playerView: YTPlayerView!
    
    var videoID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.loadWithVideoId(videoID)
    }
}