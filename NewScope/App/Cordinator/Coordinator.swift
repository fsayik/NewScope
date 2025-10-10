//
//  Coordinator.swift
//  Ink&Pixel
//
//  Created by Ferhat Şayık on 7.10.2025.
//

import UIKit


// MARK: - Coordinator
final class Coordinator: CoordinatorProtocol {
    // MARK: - Properties
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?
    
    // MARK: - Functions
    func start() {
        let vc = TabBarViewBuilder.build(coordinator: self)
        navigationController?.setViewControllers([vc],
                                                 animated: true)
    }

    func eventOccurred(with viewController: UIViewController) {
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}
