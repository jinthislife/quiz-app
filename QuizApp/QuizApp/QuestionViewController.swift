//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Jin Lee on 1/10/19.
//  Copyright © 2019 Jin Lee. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    private var question: String = ""
    private var options = [String]()

    convenience init(question: String, options: [String]) {
        self.init()
        self.question = question
        self.options = options
    }

    override func viewDidLoad() {
        headerLabel.text = question
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
}
