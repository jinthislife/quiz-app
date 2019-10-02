//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Jin Lee on 29/9/19.
//  Copyright © 2019 Jin Lee. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_RendersHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withOptions_RendersOptions() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_RendersOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.text(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.text(at: 1), "A2")
//        XCTAssertEqual(makeSUT(options: ["A1", "A2", "A3"]).tableView.text(at: 2), "A3")
    }
    
    func test_optionSelected_notifiesDelegate() {
        var receivedAnswer = ""
        let sut = makeSUT(options: ["A1"]) {
            receivedAnswer = $0
        }
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
        XCTAssertEqual(receivedAnswer, "A1")
    }
    
    // MARK: Helpers
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: @escaping ((String) -> Void) = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view // load View, Do not call viewDidLoad() directly
        return sut
    }
}


private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func text(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
}
