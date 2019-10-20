//
//  PostTableViewController+UITableViewDataSource.swift
//  SwiftHttpClient
//
//  Created by Mohit Kumar on 7/30/18.
//  Copyright © 2018 Mohit Kumar. All rights reserved.
//

import UIKit

extension PostTableViewController{
    
    // test
    override func numberOfSections(in tableView: UITableView) -> Int {
        return postViewModel.numberOfSection();
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return postViewModel.heightForRow(row: indexPath.row);
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.numberOfPosts()
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        let post:Post? = postViewModel.getPost(index: indexPath.row)
        
        cell.textLabel?.text = post?.title
        
        cell.detailTextLabel?.text = post?.body
        
        return cell
    }
    
}
