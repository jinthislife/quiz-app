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
        let sut = QuestionViewController(question: "Q1", options: [])
        
        _ = sut.view // Do not call viewDidLoad() directly
        
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_RendersZeroOptions() {
        let sut = QuestionViewController(question: "Q1", options: [])
        
        _ = sut.view // Do not call viewDidLoad() directly
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneOption_RendersOneOption() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        
        _ = sut.view // Do not call viewDidLoad() directly
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withOneOption_RendersOneOptionText() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        
        _ = sut.view // Do not call viewDidLoad() directly
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
}


