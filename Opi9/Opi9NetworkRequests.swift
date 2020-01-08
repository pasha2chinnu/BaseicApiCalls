

import Foundation

enum Opi9RequestType {

    case signup
    case signin
    case listAllUsers
}


struct RequestConstants {
    
    static let providerURL = ""
}

class Opi9NetworkRequests {
    
    // GET Requests
    static func getRequestofType(_ requestType:Opi9RequestType, headers:NSDictionary?) -> URLRequest {
        var request:URLRequest!
        switch requestType {
            
        case .signin:
            let authPath = "/users/signin.json"
            let url = RequestConstants.providerURL + authPath
            request = self.createGETRequest(url, headers:headers)
            break
            
            
            
        default:
            break
        }
        
        return request
    }
    
    // POST Requests
    static func postRequestofType(_ requestType:Opi9RequestType, headers:NSDictionary?, payload :[String:Any]? ) -> URLRequest {
        var request:URLRequest!
        switch requestType {
  
        case .signup:
            let endPoint = "/users/signup.json"
            let url = RequestConstants.providerURL + endPoint
            request = createPOSTRequest(url, headers: headers, payload: payload!)
            break
      
        default:
            break
        }
        return request
    }

    
    static func createGETRequest(_ Opi9URL:String , headers:NSDictionary?) -> URLRequest {
        var headerAsString:String = ""
        
        if (headers != nil && headers!.count > 0) {
            var separator = "?"
            for (key,value) in headers! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
            
        }
        
        let fullUrlString = Opi9URL + headerAsString;
        let url = URL(string: fullUrlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 20
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static func createPOSTRequest(_ Opi9URL:String ,headers:NSDictionary?, payload:[String:Any]) -> URLRequest {
        var headerAsString:String = ""
        
        if (headers != nil && headers!.count > 0) {
            var separator = "?"
            for (key,value) in headers! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
        }
        
        print(headers)
        
        let fullUrlString = Opi9URL + headerAsString;
        let url = URL(string: fullUrlString)
        let request = NSMutableURLRequest(url: url!)
        
        do {
            let data = try JSONSerialization.data(withJSONObject: payload, options: [])
            let post = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
            request.httpBody = post.data(using: String.Encoding.utf8);
        }catch {
            print("json error: \(error)")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        request.httpMethod = "POST"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static func createPOSTRequestWithFormData(_ Opi9URL:String ,headers:NSDictionary?, payload:NSDictionary?) -> URLRequest {
        var headerAsString:String = ""
        
        if (headers != nil && headers!.count > 0) {
            var separator = "?"
            for (key,value) in headers! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
        }
        
        print(headers)
        
        let fullUrlString = Opi9URL + headerAsString;
        let url = URL(string: fullUrlString)
        let request = NSMutableURLRequest(url: url!)
        
        var payloadString = ""
        if (payload != nil && payload!.count > 0) {
            var separator = ""
            for (key,value) in payload! {
                payloadString += separator
                payloadString += key as! String
                payloadString += "="
                payloadString += value as! String
                separator = "&"
            }
        }
        
        request.httpBody = payloadString.data(using: String.Encoding.utf8);
        
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static fileprivate func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }

   
    
}
