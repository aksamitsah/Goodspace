//
//  TabBarVC.swift
//  Goodspace
//
//  Created by Amit Shah on 06/12/23.
//

import UIKit

class TabBarVC: BaseVC {

    @IBOutlet weak var tabbar: UITabBar!
    @IBOutlet weak var containerView: UIView!
    
    let tabBarList = [
        0 : WorkVC.storyboardIdentifier,
        1 : RecruitVC.storyboardIdentifier,
        2 : SocialVC.storyboardIdentifier,
        3 : MessageVC.storyboardIdentifier,
        4 : ProfileVC.storyboardIdentifier
    ] as [Int: String]
    
    var activeIndex = 0{
        didSet{
            setViewController(tag: activeIndex)
            tabUIUpdate(tag: activeIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabbar.delegate = self
        
        tabbar.selectedItem = tabbar.items?[0]
        setViewController(tag: 0)
        tabUIUpdate(tag: 0)
        
    }
    
    func tabUIUpdate(tag: Int){
        
        UIView.animate(withDuration: 0.05) {
            
            for i in 0...4{
                if tag == i{
                    self.view.viewWithTag(101 + i)?.backgroundColor = .primaryColor
                }else if self.view.viewWithTag(101 + i)?.backgroundColor == .primaryColor{
                    self.view.viewWithTag(101 + i)?.backgroundColor = .clear
                }
            }
            
        }
        
    }
    
    func setViewController(tag: Int){
        
        if let identifier = tabBarList[tag],
           let vc = UIStoryboard(name: "GoodSpace", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier) as? BaseVC {
            AppHelper.shared.addViewController(
                controller: vc, containerView: self.containerView, currentController: self)
        }
        
    }
}

extension TabBarVC : UITabBarDelegate {

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let tag = tabBar.selectedItem?.tag{
            activeIndex = tag
        }
    }
    
}
