//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Jin Lee on 1/10/19.
//  Copyright © 2019 Jin Lee. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    private var question = ""
    private var options = [String]()
    private var selections = [String]()
    private var selection: (([String]) -> Void)? = nil
// Todo: study closure syntax. Single argument function types require parentheses, Replace '[String]' with '([String])'
    convenience init(question: String, options: [String], selection: (([String]) -> Void)?) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
    }

    override func viewDidLoad() {
        headerLabel.text = question
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        /// I don't understand why they created separate dequeueCell(in:) func
        /// without writing the line right below.
        /// let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            selection?(selectedOptions(in: tableView))
        }
    }
    
    func selectedOptions(in tableView: UITableView) -> [String] {
//        guard let selectedRows = tableView.indexPathsForSelectedRows else { return [] }
//        return selectedRows.map { options[$0.row] }
        return tableView.indexPathsForSelectedRows?.map { options[$0.row] } ?? []
    }
}
