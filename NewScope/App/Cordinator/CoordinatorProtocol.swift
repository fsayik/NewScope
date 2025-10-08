//
//  CoordinatorProtocol.swift
//  Ink&Pixel
//
//  Created by Ferhat Şayık on 7.10.2025.
//

import UIKit

// MARK: - CoordinatorProtocol
protocol CoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: CoordinatorProtocol? { get set }
    func eventOccurred(with viewController: UIViewController)
    func start()
}
