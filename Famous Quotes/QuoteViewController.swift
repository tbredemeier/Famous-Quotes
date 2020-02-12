//
//  QuoteViewController.swift
//  Famous Quotes
//
//  Created by tbredemeier on 2/11/20.
//  Copyright © 2020 tbredemeier. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    var data = [String: String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = data["title"]
        quoteLabel.text = data["quote"]
        authorLabel.text = "~ \(data["author"]!)"
    }
}
