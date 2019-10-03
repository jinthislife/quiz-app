//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Jin Lee on 3/10/19.
//  Copyright © 2019 Jin Lee. All rights reserved.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let vc = QuestionViewController(question: "Question?", options: ["Option1", "Option2"]) {
            print($0)
        }
        _ = vc.view
        vc.tableView?.allowsMultipleSelection = false
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
