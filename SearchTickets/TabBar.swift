//
//  ViewController.swift
//  SearchTickets
//
//  Created by Manas Salimzhan on 04.06.2024.
//

import UIKit

class TabBar: UITabBarController {
    
    let nav1 = UINavigationController(rootViewController: TicketsViewController())
    let nav2 = UINavigationController(rootViewController: HotelsViewController())
    let nav3 = UINavigationController(rootViewController: ShortViewController())
    let nav4 = UINavigationController(rootViewController: FollowsViewController())
    let nav5 = UINavigationController(rootViewController: ProfileViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        nav1.tabBarItem = UITabBarItem(title: "Авиабилеты", image: UIImage(named: "airplane"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Отели", image: UIImage(named: "hotels"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Короче", image: UIImage(named: "short"), tag: 2)
        nav4.tabBarItem = UITabBarItem(title: "Подписки", image: UIImage(named: "follows"), tag: 3)
        nav5.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile"), tag: 4)
        
        nav1.navigationBar.prefersLargeTitles = true
        [nav1,nav2,nav3,nav4,nav5].forEach({$0.navigationBar.prefersLargeTitles = true})
        setViewControllers([nav1,nav2,nav3,nav4,nav5], animated: true)
    }

}

