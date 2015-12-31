import Foundation

class TMDBApiClient {
    private let BASE_URL = "http://api.themoviedb.org/3";
    private let API_KEY = "860d7a52308bfdd68825f10b030d9430";
    
    static let instance = TMDBApiClient()
    private init() {
        
    }
    
    func searchMovie(query : String = "",type: String, success: (NSData -> Void)? = nil) {
        let data = ["query": query]
        self.call("/\(type)/movie", method: "GET", type: type, data: data, success: success)
    }
    
    func call(request: String, method: String, type: String, data: [String : AnyObject]?, success: (NSData -> Void)?) {
        var url = self.BASE_URL + request
        
        
        if type == "search" {
            if var queryData = data{
                queryData["api_key"] = self.API_KEY
                let dataString = queryData.stringFromHttpParameters()
                url = "\(url)?\(dataString)"
            } else {
                url = "\(url)?api_key=\(self.API_KEY)"
            }
        } else {
            url = "\(url)?api_key=\(self.API_KEY)"
        }
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: url)
        request.HTTPMethod = method
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { 
            response, data, error in
            if data == nil {
                print("data = nil")
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