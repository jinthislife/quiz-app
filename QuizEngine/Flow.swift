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
}

class Flow {
    private let router: Router
    private var questions: [String]

    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let question = questions.first {
            router.routeTo(question: question, answerCallback: routeNext(from: question))
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let strongSelf = self else { return }
            
            if let currentQuestionIndex = strongSelf.questions.firstIndex(of: question) {
                if currentQuestionIndex + 1 < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[currentQuestionIndex+1]
                    strongSelf.router.routeTo(question: nextQuestion, answerCallback: strongSelf.routeNext(from: nextQuestion))
                }
            }
        }
    }
}
