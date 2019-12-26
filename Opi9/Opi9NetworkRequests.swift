//
//  HumOSNetworkRequests.swift
//  HumOS
//
//  Created by kvanadev5 on 27/10/16.
//  Copyright © 2016 kvanadev5. All rights reserved.
//

import Foundation

enum Opi9RequestType {

    case signup
    case signin
    case listAllUsers
   
}

// Multi-part media type



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
    /*
        case .createPatient:
            let endPoint = "/auth/v2/patient_accounts/patient_account"
            let url = RequestConstants.siksoftURL + endPoint
            request = createPOSTRequest(url, headers: headers, payload: payload!)
            break
    */
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
/*
    static func uploadRequestofType(_ requestType:HumOSRequestType,queryParams:NSDictionary?, headers:NSDictionary?, payload:NSDictionary?,media : Array<MPMedia> ) -> URLRequest {
        var request:URLRequest!
        switch requestType {
        case .createImageMessage:
            let endpoint = "/messages"
            let url = RequestConstants.providerURL + RequestConstants.appEndPoint + requestType.useAppVersion() + endpoint
            request = createMultiPartPOSTRequest(url, queryParams: queryParams, headers: headers, payload: payload, media: media)
            break
        case .createVideoMessage:
            let endpoint = "/messages"
            let url = RequestConstants.providerURL + RequestConstants.appEndPoint + requestType.useAppVersion() + endpoint
            request = createMultiPartPOSTRequest(url, queryParams: queryParams, headers: headers, payload: payload, media: media)
            break
        case .createVideoThumbnail:
            let endpoint = "/thumbnail"
            let url = RequestConstants.providerURL + RequestConstants.appEndPoint + requestType.useAppVersion() + endpoint
            request = createMultiPartPOSTRequest(url, queryParams: queryParams, headers: headers, payload: payload, media: media)
            break
        case .createPetBlob:
            let endPoint = "/blobs"
            let url = RequestConstants.providerURL + RequestConstants.appEndPoint + requestType.useAppVersion() + endPoint
            request = createMultiPartPOSTRequest(url, queryParams: queryParams, headers: headers, payload: payload, media: media)
            break
                default:
            break
        }
        return request
    }
*/
    
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
    
    
    static func createDELETERequest(_ Opi9URL:String , headers:NSDictionary?) -> URLRequest {
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
        request.httpMethod = "DELETE"
        request.timeoutInterval = 20
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
    
    static func createPUTRequest(_ Opi9URL:String ,headers:NSDictionary?, payload:NSDictionary?) -> URLRequest {
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
            let data = try JSONSerialization.data(withJSONObject: payload!, options: [])
            let post = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
            request.httpBody = post.data(using: String.Encoding.utf8);
        } catch {
            print("json error: \(error)")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }
   /*
    static func createMultiPartPOSTRequest(_ SikURL:String ,queryParams:NSDictionary?, headers:NSDictionary?, payload:NSDictionary?,media : Array<MPMedia>) -> URLRequest {
        var headerAsString:String = ""
        
        let boundary = generateBoundaryString()
        
        if (queryParams != nil && queryParams!.count > 0) {
            var separator = "?"
            for (key,value) in queryParams! {
                headerAsString += separator
                headerAsString += key as! String
                headerAsString += "="
                headerAsString += value as! String
                separator = "&"
            }
        }
        
        print(queryParams)
        
        let fullUrlString = SikURL + headerAsString;
        let url = URL(string: fullUrlString)
        let request = NSMutableURLRequest(url: url!)
        
        do {
            let body = createMPBody(payload: payload, media: media , boundary: boundary)
            request.httpBody = body
        }catch {
            print("json error: \(error)")
        }
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.timeoutInterval = 80
        request.httpShouldHandleCookies=false
        return request as URLRequest
    }

    static fileprivate func createMPBody(payload: NSDictionary?, media : Array<MPMedia>, boundary: String) -> Data {
        let body = NSMutableData();
        
        if payload != nil {
            for (key, value) in payload! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        for mp: MPMedia in media {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(mp.fileKey!)\"; filename=\"\(mp.fileName)\"\r\n")
            body.appendString("Content-Type: \(mp.mimeType)\r\n\r\n")
            body.append(mp.fileData! as Data)
            body.appendString("\r\n")
            
            body.appendString("--\(boundary)--\r\n")
        }
        return body as Data
    }
*/
    
}
