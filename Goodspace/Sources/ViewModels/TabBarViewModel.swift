//
//  TabBarViewModel.swift
//  Goodspace
//
//  Created by Amit Shah on 07/12/23.
//

import Foundation


final class TabBarViewModel{
    
    let tabBarList = [
        0 : WorkVC.storyboardIdentifier,
        1 : RecruitVC.storyboardIdentifier,
        2 : SocialVC.storyboardIdentifier,
        3 : MessageVC.storyboardIdentifier,
        4 : ProfileVC.storyboardIdentifier
    ] as [Int: String]
    
    var activeIndex = 0{
        didSet{
            delegate?.setViewController(tag: activeIndex)
            delegate?.tabUIUpdate(tag: activeIndex)
        }
    }
    
    weak var delegate: TabBarVC?
    
}
