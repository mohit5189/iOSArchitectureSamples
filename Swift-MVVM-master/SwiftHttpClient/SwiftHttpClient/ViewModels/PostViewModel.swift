//
//  PostViewModel.swift
//  SwiftHttpClient
//
//  Created by Mohit Kumar on 7/30/18.
//  Copyright © 2018 Mohit Kumar. All rights reserved.
//

import UIKit

class PostViewModel: NSObject {

    var completionHandler = {() -> () in }
    
    var errorHandler = {(error:Error) -> () in }
    
    var postUrl = "https://jsonplaceholder.typicode.com/posts"

    var posts:[Post]?{
        didSet{
           refreshData()
        }
    }
    
    func refreshData(){
        
        completionHandler();
    }
    
    func numberOfPosts() -> Int {
        return self.posts?.count ?? 0
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func heightForRow(row:Int) -> CGFloat {
        return 100;
    }
    func getPost(index:Int) -> Post? {
        
        return self.posts?[index] ?? nil
    }
        
    func fetchPosts() -> Void{
        
        HTTPClient.sharedInstance.getResponse(url: postUrl, withJson: nil, apiType: .GET, onSuccess: { (data) in
            
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    
                    self.posts = try decoder.decode([Post].self, from: data)
                    
                }catch let err{
                    self.errorHandler(err)
                }
            }
            
        }) { (error) in
            print("Http error is ",error?.localizedDescription as Any)
            self.errorHandler(error!)

        }
    }

}
