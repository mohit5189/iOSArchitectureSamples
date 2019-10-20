//
//  HTTPClient.swift
//  SwiftHttpClient
//
//  Created by Mohit Kumar on 7/24/18.
//  Copyright © 2018 Mohit Kumar. All rights reserved.
//

import UIKit

enum ApiType: String{
    case GET
    case POST
}

class HTTPClient: NSObject {

    static let sharedInstance = HTTPClient() // this is used for singleton object of class
    
    func getResponse(url:String , withJson json:[String:String]? , apiType:ApiType, onSuccess:@escaping (_ data:Data?) -> Void, onFailure:@escaping (_ error:Error?) -> Void ) -> Void {
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        
        

        request.httpMethod = apiType.rawValue
        
        // Check if making POST call
        if apiType == .POST {
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

            // Add data to body
            if let body = json{

                guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
                    print("HTTP body failed to create")
                    
                    let error:NSError = NSError(domain: "Invalid body", code: 100, userInfo: nil)
                    
                    onFailure(error)

                    // return from method
                    return
                }
                request.httpBody = httpBody
            }
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error)
            } else{
                onSuccess(data)
            }
        })
        
        task.resume()
    }
    
    
}
