//
//  ViewController.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 29/01/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        
        let upcomingVC = UINavigationController(rootViewController: UpcomingViewController())
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        
        let downloadVC = UINavigationController(rootViewController: DownloadViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        upcomingVC.tabBarItem.image = UIImage(systemName: "play.circle")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        
        setViewControllers([homeVC, upcomingVC, searchVC, downloadVC], animated: true)
    }


}

