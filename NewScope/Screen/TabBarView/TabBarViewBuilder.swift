//
//  TabBarViewBuilder.swift
//  NewScope
//
//  Created by Ferhat Şayık on 11.10.2025.
//

import Foundation
import UIKit

struct TabBarViewBuilder {
    static func build(coordinator: Coordinator) -> UITabBarController {
        let tabBar = TabBarViewController(coordinator: coordinator)
        return tabBar
    }
}
