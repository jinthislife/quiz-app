//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Jin Lee on 25/9/19.
//  Copyright © 2019 Jin Lee. All rights reserved.
//
import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let sut = Flow(questions: ["Q1", "Q2"], router: router)
        sut.start()
        //        makeSUT(questions: ["Q1", "Q2"]).start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let sut = Flow(questions: ["Q1", "Q2", "Q3"], router: router)
        sut.start()
        //        makeSUT(questions: ["Q1", "Q2"]).start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let sut = Flow(questions: ["Q1"], router: router)
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    // MARK: Helpers
    
    func makeSUT(questions: [String]) -> Flow {
        return Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: Router.AnswerCallback = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping Router.AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
