//
//  NewsTableViewController.swift
//  HealthyFood
//
//  Created by Sorrapong W on 13/3/2563 BE.
//  Copyright © 2563 Sorrapong W. All rights reserved.
//

import UIKit

struct News {
    var name:String
    var file:String
    var ext:String
}

class NewsTableViewController: UITableViewController {

    let allnews:[News] = [
        News(name: "2020 FOOD & Health Survey", file: "2018-FOOD-REPORT", ext:"pdf"),
        News(name: "2019 FOOD & Health Survey", file: "2018-FOOD-REPORT", ext:"pdf"),
        News(name: "2018 FOOD & Health Survey", file: "2018-FOOD-REPORT", ext:"pdf"),
        News(name: "2017 FOOD & Health Survey", file: "2018-FOOD-REPORT", ext:"pdf"),
        News(name: "2016 FOOD & Health Survey", file: "2018-FOOD-REPORT", ext:"pdf"),
        News(name: "2015 FOOD & Health Survey", file: "2018-FOOD-REPORT", ext:"pdf"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allnews.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newscell", for: indexPath)
        
        let news = allnews[indexPath.row]
        cell.textLabel?.text = news.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = allnews[indexPath.row]
        
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newsDetailViewController : NewsDetailViewController = mainStoryboard.instantiateViewController(identifier: "newsDetail") as! NewsDetailViewController
        newsDetailViewController.filename =  news.file
        newsDetailViewController.fileext =  news.ext
        
        self.present(newsDetailViewController, animated: true)
    }

}
