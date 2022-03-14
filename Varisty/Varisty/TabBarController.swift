//
//  TabBarController.swift
//  Varisty
//
//  Created by Christian Grinling on 09/11/2020.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        let homePage = HomeFeed()
        let homeImage = UIImage(systemName: "house")
        homePage.tabBarItem = UITabBarItem(title: "Feed", image: homeImage, tag: 0)
        
        let search = Search()
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let post = Post()
        let postimage = UIImage(systemName: "plus.circle")
        post.tabBarItem = UITabBarItem(title: "Post", image: postimage, tag: 2)
        
        let activity = Activity()
        let activityimage = UIImage(systemName: "equal.square")
        activity.tabBarItem = UITabBarItem(title: "Activity", image: activityimage, tag: 3)
        
        let profile = Profile()
        let profileimage = UIImage(systemName: "person")
        profile.tabBarItem = UITabBarItem(title: "Profile", image: profileimage, tag: 4)
        
        let tabbarList = [homePage, search, post, activity, profile]
        
        viewControllers = tabbarList.map {
            UINavigationController(rootViewController: $0)
        }
        
    }

}
