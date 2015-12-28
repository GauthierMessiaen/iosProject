import Foundation

class TMDBApiClient {
    private let BASE_URL = "http://api.themoviedb.org/3";
    private let API_KEY = "860d7a52308bfdd68825f10b030d9430";
    
    static let instance = TMDBApiClient()
    private init() {
        
    }
    
    func searchMovie(query : String = "star", success: (NSData -> Void)? = nil) {
        let data = ["query": query]
        self.call("/search/movie", method: "GET", data: data, success: success)
    }
    
    func call(request: String, method: String, data: [String : AnyObject]?, success: (NSData -> Void)?) {
        var url = self.BASE_URL + request
        
        if var queryData = data{
            queryData["api_key"] = self.API_KEY
            let dataString = queryData.stringFromHttpParameters()
            url = "\(url)?\(dataString)"
        } else {
            url = "\(url)?api_key=\(self.API_KEY)"
        }
        
        print(url)
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = method
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { 
            response, data, error in
            if data == nil {
                print("fail")
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                if statusCode != 200 {
                    print("error -> status not 200")
                } else {
                    if success != nil{
                        success!(data!)
                    }
                }
            }
            
            
        }
        
    }
    
}