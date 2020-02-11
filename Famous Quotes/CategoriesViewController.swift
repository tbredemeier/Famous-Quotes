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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quotation Categories"
        let query = "https://quotes.rest/qod/categories.json"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                let success = json["success"].dictionary
                if success!["total"]! > 0 {
                    parse(json: json)
                    return
                }
            }
        }
        loadError()
    }

    func parse(json: JSON) {
        let contents = json["contents"].dictionary
        for (key, subJson) in contents!["categories"]! {
            categories.append((key, subJson.stringValue))
        }
    }

    func loadError() {
        let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the quotation categories", preferredStyle: .actionSheet)
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
}

