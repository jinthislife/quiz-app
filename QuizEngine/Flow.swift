//
//  Flow.swift
//  QuizEngine
//
//  Created by Jin Lee on 25/9/19.
//  Copyright © 2019 Jin Lee. All rights reserved.
//

import Foundation

protocol Router { //an abastraction to the next question handler
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

class Flow {
    private let router: Router
    private var questions: [String]
    private var result: [String: String] = [:]

    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    // you can write start() in multiple ways using guard let or returning router.routeTo()
    func start() {
        if let question = questions.first {
            router.routeTo(question: question, answerCallback: nextCallback(from: question))
        } else {
            router.routeTo(result: result)
        }
    }
    
    private func nextCallback(from question: String) -> Router.AnswerCallback {
        return { [weak self] in
            self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: String, _ answer: String) {
        result[question] = answer
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }
        }
    }
}
