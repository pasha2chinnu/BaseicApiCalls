//
//  NetworkInterface.swift
//  HumOS
//
//  Created by Nandu Ahmed on 8/30/16.
//  Copyright © 2016 Sikka Software. All rights reserved.
//

import Foundation



typealias HumOSRequestCompletionType = (Bool, NSDictionary?, URLResponse?, Error?) -> (Void)

class NetworkInterface: NSObject {
    
    static func fetchJSON(_ requestType:HumOSRequestType , headers:NSDictionary? , requestCompletionHander:@escaping HumOSRequestCompletionType)  {
        
        self.sendAsyncRequest(HumOSNetworkRequests.getRequestofType(requestType, headers: headers)) { (success, json, response, error) -> (Void) in
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
                    requestCompletionHander(false, nil, response, HumOSNetworkError.httpStatus204)
                    break
                case 404:
                    requestCompletionHander(false,nil,response,HumOSNetworkError.httpStatus404)
                    break
                case 410:
                    requestCompletionHander(false, nil, response, HumOSNetworkError.httpStatus410)
                    break
                default:
                    requestCompletionHander(false,nil,response,HumOSNetworkError.httpStatusUnknownError)
                    break
                }
            }
            else {
                requestCompletionHander(false,nil,response,error)
            }
            
        }
    }
    
    static func fetchJSON(_ requestType:HumOSRequestType , headers:NSDictionary?, payload :[String:Any]  , requestCompletionHander:@escaping HumOSRequestCompletionType) {
        let priority = DispatchQueue.GlobalQueuePriority.default
        DispatchQueue.global(priority: priority).async {
            //TODO: Implement the cases for HTTP Code as for GET and TEST
            self.sendAsyncRequest(HumOSNetworkRequests.postRequestofType(requestType, headers:headers, payload: payload  ), completionHandler: { (suc, json, response, error) -> (Void) in
                let succcess = (json != nil)
                requestCompletionHander(succcess,json, response,error)
                
            })
        }
    }
    
//    static func upload(_ requestType:HumOSRequestType , queryParams:NSDictionary?, headers:NSDictionary?, payload:NSDictionary?, media:Array<MPMedia>, requestCompletionHander:@escaping HumOSRequestCompletionType) {
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
    
    
    static fileprivate func sendAsyncRequest(_ request:URLRequest, completionHandler:@escaping HumOSRequestCompletionType) {
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
