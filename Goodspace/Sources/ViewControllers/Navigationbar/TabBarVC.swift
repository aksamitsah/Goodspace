//
//  TabBarVC.swift
//  Goodspace
//
//  Created by Amit Shah on 06/12/23.
//

import UIKit

class TabBarVC: BaseVC {

    @IBOutlet weak private var tabbar: UITabBar!
    @IBOutlet weak private var containerView: UIView!
    
    @IBOutlet weak private var circle: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    
    private let viewModel = TabBarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initilizeValue()
        
    }
    
    
    private func tabUIUpdate(tag: Int){
        
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
    
    private func setViewController(tag: Int){
        
        if let identifier = viewModel.tabBarList[tag],
           let vc = UIStoryboard(name: "GoodSpace", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier) as? BaseVC {
            AppHelper.shared.addViewController(
                controller: vc, containerView: self.containerView, currentController: self)
        }
        
    }
}

extension TabBarVC : UITabBarDelegate {
    
    internal func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let tag = tabBar.selectedItem?.tag{
            viewModel.activeIndex = tag
        }
    }
}

extension TabBarVC : TabBarViewModelProtocal {
    
    internal func updateUI(for activeIndex: Int) {
        setViewController(tag: activeIndex)
        tabUIUpdate(tag: activeIndex)
    }
    
}

extension TabBarVC {
    
    private func setupUI(){
        
        tabbar.delegate = self
        viewModel.delegate = self
        
    }

    private func initilizeValue(){
        
        circle.setImageWithProgress(lineWidth: 2.6, stroke: 0.6, image: imageView, imageUrl: "", placeholder: UIImage(systemName: "person.circle.fill"))
        
        tabbar.selectedItem = tabbar.items?[0]
        tabUIUpdate(tag: 0)
        setViewController(tag: 0)
        
    }
    
}
