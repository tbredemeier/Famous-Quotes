//
//  ViewController.swift
//  Famous Quotes
//
//  Created by tbredemeier on 2/11/20.
//  Copyright © 2020 tbredemeier. All rights reserved.
//

import UIKit

class CategoriesViewController: UITableViewController {

    var categories = [(String, String)]()
    let prefix = "https://quotes.rest/qod"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quotation Categories"
        let query = "\(prefix)/categories.json"
        if let json = makeQuery(query: query) {
            let success = json["success"].dictionary
            if success!["total"]! > 0 {
                let contents = json["contents"].dictionary
                for (key, subJson) in contents!["categories"]! {
                    categories.append((key, subJson.stringValue))
                }
            }
        }
    }

    func makeQuery(query: String) -> JSON? {
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                return json
            }
        }
        loadError()
        return nil
    }

    func loadError() {
        let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the data", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.0
        cell.detailTextLabel?.text = category.1
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! QuoteViewController
        let index = (tableView.indexPathForSelectedRow?.row)!
        let category = categories[index].0
        let query = "\(prefix).json?category=\(category)"
        if let json = makeQuery(query: query) {
            let success = json["success"].dictionary
            if success!["total"]! > 0 {
                let contents = json["contents"].dictionary
                for (_, subJson) in contents!["quotes"]! {
                    let title = subJson["title"].stringValue
                    let quote = subJson["quote"].stringValue
                    let author = subJson["author"].stringValue
                    let data = ["title": title, "quote": quote, "author": author]
                    dvc.data = data
                }
            }
        }
    }
}

