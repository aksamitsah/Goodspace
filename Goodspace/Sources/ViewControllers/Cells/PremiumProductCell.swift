//
//  PremiumProductCell.swift
//  Goodspace
//
//  Created by Amit Shah on 07/12/23.
//

import UIKit

class PremiumProductCell: UICollectionViewCell {
    
    
    @IBOutlet weak var verifiedImg: UIImageView!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var designation: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    var data: PremiumProductResponse?{
        didSet{
            updateUI()
            initilizeValue()
        }
    }
    
    func initilizeValue(){
        
        guard let data else { return }
        
        verifiedImg.isHidden = Bool.random()
        userProfile.image = UIImage(named: "00\(Int.random(in: 1...5))")
        name.text = data.displayName
        designation.text = data.productName
        
    }
    
    func updateUI(){
        mainView.defaultTheme(cornerRadius: 10, borderWidth: 2, borderColor: .primaryColor, backgroundColor: .clear)
    }
    
    static var identifier: String {
        return "PremiumProductCell"
    }
    
}
