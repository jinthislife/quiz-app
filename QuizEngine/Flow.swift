//
//  Flow.swift
//  QuizEngine
//
//  Created by Jin Lee on 25/9/19.
//  Copyright © 2019 Jin Lee. All rights reserved.
//

import Foundation

protocol Router { //an abastraction to the next question handler
    func routeTo(question: String, answerCallback: @escaping (String) -> Void)
}

class Flow {
    let router: Router
    var questions: [String]

    init(questions: [String], router: Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let question = questions.first {
            router.routeTo(question: question) { [weak self] _ in
                guard let strongSelf = self else { return }
                let firstQuestionIndex = strongSelf.questions.firstIndex(of: question)!
                let nextQuestion = strongSelf.questions[firstQuestionIndex+1]
                strongSelf.router.routeTo(question: nextQuestion) { _ in }
            }
        }
    }
}
