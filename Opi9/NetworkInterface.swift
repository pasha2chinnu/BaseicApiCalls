
//
//  Created by kvanadev5 on 27/10/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import Foundation



typealias Opi9RequestCompletionType = (Bool, NSDictionary?, URLResponse?, Error?) -> (Void)

class NetworkInterface: NSObject {
    
    static func fetchJSON(_ requestType:Opi9RequestType , headers:NSDictionary? , requestCompletionHander:@escaping Opi9RequestCompletionType)  {
        
        self.sendAsyncRequest(Opi9NetworkRequests.getRequestofType(requestType, headers: headers)) { (success, json, response, error) -> (Void) in
            if (success == true && response != nil) {
                
                let httpResponse:HTTPURLResponse = response as! HTTPURLResponse
                let httpStatusCode = httpResponse.statusCode
                
                switch httpStatusCode {
                    
                case 200:
                    let succcess = (json != nil)
                    if (succcess) {
                        requestCompletionHander(succcess, json, response, nil)
                    } else {
                        requestCompletionHander(false, nil, response , DataErrors.invalidJSONData)
                    }
                    break
                    
                case 204:
                    requestCompletionHander(false, nil, response, Opi9NetworkError.httpStatus204)
                    break
                case 404:
                    requestCompletionHander(false,nil,response,Opi9NetworkError.httpStatus404)
                    break
                case 410:
                    requestCompletionHander(false, nil, response, Opi9NetworkError.httpStatus410)
                    break
                default:
                    requestCompletionHander(false,nil,response,Opi9NetworkError.httpStatusUnknownError)
                    break
                }
            }
            else {
                requestCompletionHander(false,nil,response,error)
            }
            
        }
    }
    
    static func fetchJSON(_ requestType:Opi9RequestType , headers:NSDictionary?, payload :[String:Any]  , requestCompletionHander:@escaping Opi9RequestCompletionType) {
        let priority = DispatchQueue.GlobalQueuePriority.default
        DispatchQueue.global(priority: priority).async {
            //TODO: Implement the cases for HTTP Code as for GET and TEST
            self.sendAsyncRequest(Opi9NetworkRequests.postRequestofType(requestType, headers:headers, payload: payload  ), completionHandler: { (suc, json, response, error) -> (Void) in
                let succcess = (json != nil)
                requestCompletionHander(succcess,json, response,error)
                
            })
        }
    }
    
//    static func upload(_ requestType:HumOSRequestType , queryParams:NSDictionary?, headers:NSDictionary?, payload:NSDictionary?, media:Array<MPMedia>, requestCompletionHander:@escaping Opi9RequestCompletionType) {
//        let priority = DispatchQueue.GlobalQueuePriority.default
//        DispatchQueue.global(priority: priority).async {
//            //TODO: Implement the cases for HTTP Code as for GET and TEST
//            self.sendAsyncRequest(HumOSNetworkRequests.uploadRequestofType(requestType, queryParams: queryParams, headers: headers, payload: payload, media: media ), completionHandler: { (suc, json, response, error) -> (Void) in
//                let succcess = (json != nil)
//                requestCompletionHander(succcess,json, response,error)
//                
//            })
//            
//        }
//    }
    
    
    static fileprivate func sendAsyncRequest(_ request:URLRequest, completionHandler:@escaping Opi9RequestCompletionType) {
        let queue:OperationQueue = OperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response, data, error) in
            do {
                if (response != nil && data != nil) {
                    if let json = try JSONSerialization.jsonObject(with: data!, options:[]) as? AnyObject {
                        print("Response from DISPATCH ASYNC URL \(response?.url) \(json)")
                        if (json is NSArray) {
                            let arrayOfJson = ["array":json]
                            completionHandler(true,arrayOfJson as NSDictionary?, (response as! HTTPURLResponse), nil)
                        } else {
                            completionHandler(true,json as? NSDictionary ,(response  as! HTTPURLResponse), nil)
                        }
                    } else {
                        completionHandler(false, nil, (response as! HTTPURLResponse), DataErrors.invalidJSONData)
                    }
                } else {
                    if let data = data, let json = try JSONSerialization.jsonObject(with: data, options:[]) as? AnyObject {
                        print(json)
                    }
                    completionHandler(false, nil, response , DataErrors.noData)
                }
            }catch let error as NSError {
                print(error.localizedDescription)
                completionHandler(false, nil,response,DataErrors.dataParseError)
            }
            
        }
    }
}
